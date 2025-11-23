impl Solution {
    pub fn possibly_equals(s1: String, s2: String) -> bool {
        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();
        let n = s1_chars.len();
        let m = s2_chars.len();
        let mut memo = vec![vec![vec![None; 2000]; m + 1]; n + 1];
        Self::dfs(0, 0, 0, &s1_chars, &s2_chars, &mut memo)
    }

    fn dfs(
        i: usize,
        j: usize,
        diff: i32,
        s1: &[char],
        s2: &[char],
        memo: &mut Vec<Vec<Vec<Option<bool>>>>,
    ) -> bool {
        if i == s1.len() && j == s2.len() {
            return diff == 0;
        }
        if let Some(res) = memo[i][j][(diff + 1000) as usize] {
            return res;
        }
        let mut res = false;
        if i < s1.len() && s1[i].is_ascii_digit() {
            let mut k = i;
            let mut num = 0;
            while k < s1.len() && s1[k].is_ascii_digit() {
                num = num * 10 + (s1[k] as u8 - b'0') as i32;
                k += 1;
                res |= Self::dfs(k, j, diff - num, s1, s2, memo);
            }
        } else if j < s2.len() && s2[j].is_ascii_digit() {
            let mut k = j;
            let mut num = 0;
            while k < s2.len() && s2[k].is_ascii_digit() {
                num = num * 10 + (s2[k] as u8 - b'0') as i32;
                k += 1;
                res |= Self::dfs(i, k, diff + num, s1, s2, memo);
            }
        } else if diff == 0 {
            if i < s1.len() && j < s2.len() && s1[i] == s2[j] {
                res |= Self::dfs(i + 1, j + 1, 0, s1, s2, memo);
            }
        } else if diff > 0 {
            if i < s1.len() {
                res |= Self::dfs(i + 1, j, diff - 1, s1, s2, memo);
            }
        } else {
            if j < s2.len() {
                res |= Self::dfs(i, j + 1, diff + 1, s1, s2, memo);
            }
        }
        memo[i][j][(diff + 1000) as usize] = Some(res);
        res
    }
}