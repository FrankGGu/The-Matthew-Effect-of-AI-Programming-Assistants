impl Solution {
    pub fn find_the_string(lcp: Vec<Vec<i32>>) -> String {
        let n = lcp.len();
        if n == 0 {
            return String::new();
        }
        let mut res = vec![0 as u8; n];
        let mut c = b'a';
        for i in 0..n {
            if res[i] != 0 {
                continue;
            }
            if c > b'z' {
                return String::new();
            }
            res[i] = c;
            for j in i + 1..n {
                if lcp[i][j] > 0 {
                    if res[j] != 0 && res[j] != c {
                        return String::new();
                    }
                    res[j] = c;
                }
            }
            c += 1;
        }
        for i in 0..n {
            for j in 0..n {
                let current_lcp = if i == j {
                    (n - i) as i32
                } else if i < n && j < n && res[i] == res[j] {
                    if i + 1 < n && j + 1 < n {
                        lcp[i + 1][j + 1] + 1
                    } else {
                        1
                    }
                } else {
                    0
                };
                if current_lcp != lcp[i][j] {
                    return String::new();
                }
            }
        }
        String::from_utf8(res).unwrap()
    }
}