impl Solution {
    pub fn max_num_of_substrings(s: String) -> Vec<String> {
        let s = s.as_bytes();
        let mut first = vec![std::usize::MAX; 26];
        let mut last = vec![std::usize::MIN; 26];

        for (i, &c) in s.iter().enumerate() {
            let idx = (c - b'a') as usize;
            first[idx] = first[idx].min(i);
            last[idx] = last[idx].max(i);
        }

        let mut intervals = vec![];
        for i in 0..26 {
            if first[i] != std::usize::MAX {
                let mut left = first[i];
                let mut right = last[i];
                let mut valid = true;

                let mut j = left + 1;
                while j < right {
                    let idx = (s[j] - b'a') as usize;
                    if first[idx] < left {
                        valid = false;
                        break;
                    }
                    right = right.max(last[idx]);
                    j += 1;
                }

                if valid {
                    intervals.push((left, right));
                }
            }
        }

        intervals.sort_by(|a, b| a.1.cmp(&b.1));

        let mut res = vec![];
        let mut prev_end = std::usize::MIN;
        for &(start, end) in intervals.iter() {
            if start > prev_end {
                res.push(String::from_utf8(s[start..=end].to_vec()).unwrap());
                prev_end = end;
            }
        }

        res
    }
}