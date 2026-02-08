impl Solution {
    pub fn max_num_of_substrings(s: String) -> Vec<String> {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut left = vec![n; 26];
        let mut right = vec![-1; 26];

        for i in 0..n {
            let idx = (s_bytes[i] - b'a') as usize;
            left[idx] = left[idx].min(i);
            right[idx] = right[idx].max(i as i32);
        }

        let mut intervals: Vec<(usize, i32)> = Vec::new();
        for i in 0..26 {
            if left[i] < n {
                let mut l = left[i];
                let mut r = right[i];
                let mut j = l;
                while j <= r as usize {
                    let idx = (s_bytes[j] - b'a') as usize;
                    l = l.min(left[idx]);
                    r = r.max(right[idx]);
                    j += 1;
                }
                intervals.push((l, r));
            }
        }

        intervals.sort_by(|a, b| a.1.cmp(&b.1));

        let mut ans: Vec<String> = Vec::new();
        let mut end = -1;
        for (l, r) in intervals {
            if l as i32 > end {
                ans.push(s[l..=(r as usize)].to_string());
                end = r;
            }
        }

        ans
    }
}