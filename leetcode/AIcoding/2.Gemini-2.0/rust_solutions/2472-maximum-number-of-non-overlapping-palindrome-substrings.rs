impl Solution {
    pub fn max_number_of_non_overlapping_palindromes(s: String, k: i32) -> i32 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let k = k as usize;

        let mut dp = vec![0; n + 1];

        for i in 1..=n {
            dp[i] = dp[i - 1];
            for j in (0..i).rev() {
                if i - j >= k && Self::is_palindrome(&s, j, i - 1) {
                    dp[i] = dp[i].max(dp[j] + 1);
                }
            }
        }

        dp[n]
    }

    fn is_palindrome(s: &Vec<char>, start: usize, end: usize) -> bool {
        let mut left = start;
        let mut right = end;
        while left < right {
            if s[left] != s[right] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }
}