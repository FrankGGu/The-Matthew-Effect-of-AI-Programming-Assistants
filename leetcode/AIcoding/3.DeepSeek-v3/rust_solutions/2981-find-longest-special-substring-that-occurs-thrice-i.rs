impl Solution {
    pub fn maximum_length(s: String) -> i32 {
        let mut freq = std::collections::HashMap::new();
        let s_chars: Vec<char> = s.chars().collect();
        let mut i = 0;
        let n = s_chars.len();

        while i < n {
            let mut j = i;
            while j < n && s_chars[j] == s_chars[i] {
                j += 1;
            }
            let len = j - i;
            let c = s_chars[i];
            for l in 1..=len {
                *freq.entry((c, l)).or_insert(0) += len - l + 1;
            }
            i = j;
        }

        let mut max_len = -1;
        for ((_, l), cnt) in freq {
            if cnt >= 3 {
                max_len = max_len.max(l as i32);
            }
        }
        max_len
    }
}