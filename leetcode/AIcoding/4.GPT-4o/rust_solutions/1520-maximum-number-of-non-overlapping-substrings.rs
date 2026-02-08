impl Solution {
    pub fn max_num_of_substrings(s: String) -> Vec<String> {
        let mut intervals = vec![];
        let n = s.len();
        let mut first = vec![n; 26];
        let mut last = vec![0; 26];

        for (i, c) in s.chars().enumerate() {
            let idx = (c as usize - 'a' as usize);
            first[idx] = first[idx].min(i);
            last[idx] = last[idx].max(i);
        }

        for i in 0..26 {
            if first[i] < n {
                let mut l = first[i];
                let mut r = last[i];
                for j in i + 1..26 {
                    if first[j] <= r && last[j] > r {
                        r = last[j];
                    }
                }
                intervals.push((l, r));
            }
        }

        intervals.sort_by_key(|&(l, r)| (r, l));
        let mut res = Vec::new();
        let mut end = -1;

        for (l, r) in intervals {
            if l > end {
                res.push(s[l..=r].to_string());
                end = r as i32;
            }
        }

        res
    }
}