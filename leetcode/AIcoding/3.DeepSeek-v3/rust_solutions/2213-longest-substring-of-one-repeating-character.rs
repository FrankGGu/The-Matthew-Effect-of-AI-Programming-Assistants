use std::collections::BTreeSet;

struct Segment {
    left: i32,
    right: i32,
    ch: char,
    len: i32,
}

impl PartialEq for Segment {
    fn eq(&self, other: &Self) -> bool {
        self.len == other.len && self.left == other.left
    }
}

impl Eq for Segment {}

impl PartialOrd for Segment {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl Ord for Segment {
    fn cmp(&self, other: &Self) -> std::cmp::Ordering {
        if self.len != other.len {
            self.len.cmp(&other.len).reverse()
        } else {
            self.left.cmp(&other.left)
        }
    }
}

struct Solution;

impl Solution {
    pub fn longest_repeating(s: String, query_characters: String, query_indices: Vec<i32>) -> Vec<i32> {
        let s_chars: Vec<char> = s.chars().collect();
        let query_chars: Vec<char> = query_characters.chars().collect();
        let n = s_chars.len();
        let mut segments = BTreeSet::new();
        let mut seg_map = std::collections::BTreeMap::new();

        let mut left = 0;
        for i in 1..=n {
            if i == n || s_chars[i] != s_chars[left] {
                let seg = Segment {
                    left: left as i32,
                    right: (i - 1) as i32,
                    ch: s_chars[left],
                    len: (i - left) as i32,
                };
                segments.insert(seg);
                for j in left..i {
                    seg_map.insert(j as i32, seg);
                }
                left = i;
            }
        }

        let mut res = Vec::new();
        let mut max_len = segments.iter().next().unwrap().len;

        for (idx, &pos) in query_indices.iter().enumerate() {
            let new_ch = query_chars[idx];
            if let Some(seg) = seg_map.get(&pos) {
                if seg.ch == new_ch {
                    res.push(max_len);
                    continue;
                }

                let seg = seg.clone();
                segments.remove(&seg);

                let left_seg = Segment {
                    left: seg.left,
                    right: pos - 1,
                    ch: seg.ch,
                    len: pos - seg.left,
                };

                let right_seg = Segment {
                    left: pos + 1,
                    right: seg.right,
                    ch: seg.ch,
                    len: seg.right - pos,
                };

                let new_seg = Segment {
                    left: pos,
                    right: pos,
                    ch: new_ch,
                    len: 1,
                };

                if left_seg.len > 0 {
                    segments.insert(left_seg);
                    for j in left_seg.left..=left_seg.right {
                        seg_map.insert(j, left_seg);
                    }
                }

                if right_seg.len > 0 {
                    segments.insert(right_seg);
                    for j in right_seg.left..=right_seg.right {
                        seg_map.insert(j, right_seg);
                    }
                }

                segments.insert(new_seg);
                seg_map.insert(pos, new_seg);

                if pos > 0 {
                    if let Some(left_neighbor) = seg_map.get(&(pos - 1)) {
                        if left_neighbor.ch == new_ch {
                            let left_neighbor = left_neighbor.clone();
                            segments.remove(&left_neighbor);
                            segments.remove(&new_seg);

                            let merged = Segment {
                                left: left_neighbor.left,
                                right: new_seg.right,
                                ch: new_ch,
                                len: left_neighbor.len + new_seg.len,
                            };

                            segments.insert(merged);
                            for j in merged.left..=merged.right {
                                seg_map.insert(j, merged);
                            }
                        }
                    }
                }

                if pos < (n - 1) as i32 {
                    if let Some(right_neighbor) = seg_map.get(&(pos + 1)) {
                        if right_neighbor.ch == new_ch {
                            let right_neighbor = right_neighbor.clone();
                            let current_seg = seg_map.get(&pos).unwrap().clone();
                            segments.remove(&right_neighbor);
                            segments.remove(&current_seg);

                            let merged = Segment {
                                left: current_seg.left,
                                right: right_neighbor.right,
                                ch: new_ch,
                                len: current_seg.len + right_neighbor.len,
                            };

                            segments.insert(merged);
                            for j in merged.left..=merged.right {
                                seg_map.insert(j, merged);
                            }
                        }
                    }
                }

                max_len = segments.iter().next().unwrap().len;
            }
            res.push(max_len);
        }

        res
    }
}