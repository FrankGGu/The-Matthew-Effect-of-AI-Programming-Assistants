impl Solution {
    pub fn is_valid(s1: String, s2: String) -> bool {
        let n1 = s1.len();
        let n2 = s2.len();
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();

        let mut memo: Vec<Vec<Option<bool>>> = vec![vec![None; n2 + 1]; n1 + 1];

        fn solve(i: usize, j: usize, s1_bytes: &[u8], s2_bytes: &[u8], memo: &mut Vec<Vec<Option<bool>>>) -> bool {
            let n1 = s1_bytes.len();
            let n2 = s2_bytes.len();

            if i == n1 && j == n2 {
                return true;
            }

            if memo[i][j].is_some() {
                return memo[i][j].unwrap();
            }

            let mut result = false;

            if i < n1 && s1_bytes[i].is_ascii_digit() {
                let mut num = 0;
                let mut k = i;
                while k < n1 && s1_bytes[k].is_ascii_digit() {
                    num = num * 10 + (s1_bytes[k] - b'0') as i32;
                    if num > 0 && num <= n2 as i32 - j as i32 {
                         if solve(k+1, j + num as usize, s1_bytes, s2_bytes, memo) {
                             result = true;
                             break;
                         }
                    }
                    if num > 100 {
                        break;
                    }
                    k += 1;
                }
            } else if i < n1 && j < n2 && s1_bytes[i] == s2_bytes[j] {
                result = solve(i + 1, j + 1, s1_bytes, s2_bytes, memo);
            }

            memo[i][j] = Some(result);
            result
        }

        solve(0, 0, s1_bytes, s2_bytes, &mut memo)
    }
}