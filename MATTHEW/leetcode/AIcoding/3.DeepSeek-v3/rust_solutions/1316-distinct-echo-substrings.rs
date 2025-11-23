impl Solution {
    pub fn distinct_echo_substrings(text: String) -> i32 {
        use std::collections::HashSet;
        let n = text.len();
        let mut set = HashSet::new();
        let s = text.as_bytes();

        for i in 0..n {
            for j in i + 1..n {
                let len = j - i;
                if j + len <= n {
                    let a = &s[i..j];
                    let b = &s[j..j + len];
                    if a == b {
                        set.insert(a);
                    }
                }
            }
        }

        set.len() as i32
    }
}