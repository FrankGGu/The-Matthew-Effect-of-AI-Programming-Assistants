impl Solution {
    pub fn can_make_palindrome(s: String, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut prefix = vec![vec![0; 26]; n + 1];
        for i in 0..n {
            for j in 0..26 {
                prefix[i + 1][j] = prefix[i][j];
            }
            prefix[i + 1][s[i] as usize - 'a' as usize] += 1;
        }

        let mut ans = Vec::new();
        for query in queries {
            let l = query[0] as usize;
            let r = query[1] as usize;
            let k = query[2] as i32;

            let mut odd_count = 0;
            for i in 0..26 {
                if (prefix[r + 1][i] - prefix[l][i]) % 2 != 0 {
                    odd_count += 1;
                }
            }

            ans.push(odd_count / 2 <= k);
        }

        ans
    }
}