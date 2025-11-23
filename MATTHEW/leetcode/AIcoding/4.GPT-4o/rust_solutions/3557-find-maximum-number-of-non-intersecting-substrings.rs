impl Solution {
    pub fn max_num_of_substrings(s: String) -> Vec<String> {
        let n = s.len();
        let s = s.as_bytes();
        let mut first = vec![n; 26];
        let mut last = vec![0; 26];

        for (i, &c) in s.iter().enumerate() {
            let idx = (c - b'a') as usize;
            first[idx] = first[idx].min(i);
            last[idx] = i + 1;
        }

        let mut intervals = vec![];
        for i in 0..26 {
            if first[i] < n {
                let start = first[i];
                let end = last[i];
                let mut valid = true;
                for j in start..end {
                    let idx = (s[j] - b'a') as usize;
                    end = end.max(last[idx]);
                }
                intervals.push((start, end));
            }
        }

        intervals.sort_by_key(|(start, end)| (*start, *end));

        let mut result = vec![];
        let mut last_end = -1;

        for (start, end) in intervals {
            if start > last_end {
                result.push(s[start..end].to_string());
                last_end = end as i32 - 1;
            }
        }

        result
    }
}