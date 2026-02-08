impl Solution {
    pub fn find_the_string(lcp: Vec<Vec<i32>>) -> String {
        let n = lcp.len();
        let mut s = vec![' '; n];
        let mut c = 'a';
        for i in 0..n {
            if s[i] == ' ' {
                s[i] = c;
                c = (c as u8 + 1) as char;
            }
            for j in i + 1..n {
                if lcp[i][j] > 0 {
                    s[j] = s[i];
                }
            }
        }

        for i in 0..n {
            for j in 0..n {
                let mut len = 0;
                if s[i] == s[j] {
                    len = 1;
                    while i + len < n && j + len < n && s[i + len] == s[j + len] {
                        len += 1;
                    }
                }
                if lcp[i][j] != len as i32 {
                    return String::new();
                }
            }
        }

        s.into_iter().collect()
    }
}