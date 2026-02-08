impl Solution {
    pub fn find_the_string(lcp: Vec<Vec<i32>>) -> Vec<String> {
        let n = lcp.len();
        if n == 0 {
            return vec![];
        }
        let mut res = vec!['a'; n];
        let mut c = b'a';
        for i in 0..n {
            if res[i] == 'a' {
                if c > b'z' {
                    return vec![];
                }
                res[i] = c as char;
                for j in i + 1..n {
                    if lcp[i][j] > 0 {
                        if res[j] != 'a' && res[j] != res[i] {
                            return vec![];
                        }
                        res[j] = res[i];
                    }
                }
                c += 1;
            }
        }

        for i in (0..n).rev() {
            for j in (0..n).rev() {
                if res[i] != res[j] {
                    if lcp[i][j] != 0 {
                        return vec![];
                    }
                } else {
                    if i == n - 1 || j == n - 1 {
                        if lcp[i][j] != 1 {
                            return vec![];
                        }
                    } else {
                        if lcp[i][j] != lcp[i + 1][j + 1] + 1 {
                            return vec![];
                        }
                    }
                }
            }
        }

        vec![res.iter().collect()]
    }
}