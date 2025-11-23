impl Solution {
    pub fn count_palindromic_subsequence(s: String) -> i32 {
        let s = s.chars().collect::<Vec<_>>();
        let mut first = [None; 26];
        let mut last = [None; 26];
        let n = s.len();

        for (i, &c) in s.iter().enumerate() {
            let idx = (c as usize - 'a' as usize);
            if first[idx].is_none() {
                first[idx] = Some(i);
            }
            last[idx] = Some(i);
        }

        let mut result = std::collections::HashSet::new();

        for i in 0..26 {
            if let (Some(l), Some(r)) = (first[i], last[i]) {
                if l < r {
                    let mut chars = std::collections::HashSet::new();
                    for j in l + 1..r {
                        chars.insert(s[j]);
                    }
                    result.extend(chars);
                }
            }
        }

        result.len() as i32
    }
}