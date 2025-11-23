impl Solution {
    pub fn max_num_of_substrings(s: String) -> Vec<String> {
        let n = s.len();
        let s = s.as_bytes();
        let mut left = vec![n; 26];
        let mut right = vec![0; 26];
        for i in 0..n {
            let c = (s[i] - b'a') as usize;
            left[c] = left[c].min(i);
            right[c] = right[c].max(i);
        }

        let mut intervals = vec![];
        for i in 0..26 {
            if left[i] < n {
                let mut l = left[i];
                let mut r = right[i];
                let mut j = l;
                while j <= r {
                    let c = (s[j] - b'a') as usize;
                    if left[c] < l {
                        l = left[c];
                        j = l;
                        continue;
                    }
                    r = r.max(right[c]);
                    j += 1;
                }
                intervals.push((l, r));
            }
        }

        intervals.sort_by(|a, b| a.1.cmp(&b.1));

        let mut result = vec![];
        let mut end = -1;
        for (l, r) in intervals {
            if l as i32 > end {
                result.push(String::from_utf8(s[l..=r].to_vec()).unwrap());
                end = r as i32;
            }
        }

        result
    }
}