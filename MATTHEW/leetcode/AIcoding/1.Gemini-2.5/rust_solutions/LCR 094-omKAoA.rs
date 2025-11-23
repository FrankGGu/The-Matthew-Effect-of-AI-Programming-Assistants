impl Solution {
    pub fn min_cut(s: String) -> i32 {
        let n = s.len();
        if n <= 1 {
            return 0;
        }

        let chars: Vec<char> = s.chars().collect();

        let mut is_palindrome = vec![vec![false; n]; n];

        // All single characters are palindromes
        for i in 0..n {
            is_palindrome[i][i] = true;
        }

        // Check for palindromes of length 2
        for i in 0..(n - 1) {
            if chars[i] == chars[i + 1] {
                is_palindrome[i][i + 1] = true;
            }
        }

        // Check for palindromes of length 3 or more
        for len in 3..=n {
            for i in 0..=(n - len) {
                let j = i + len - 1;
                if chars[i] == chars[j] && is_palindrome[i + 1][j - 1] {
                    is_palindrome[i][j] = true;
                }
            }
        }

        // dp[i] will store the minimum cuts needed for the prefix s[0..=i]
        let mut dp = vec![0; n];

        for i in 0..n {
            if is_palindrome[0][i] {
                dp[i] = 0;
            } else {
                // Initialize with the maximum possible cuts for s[0..=i], which is i
                // (e.g., "abc" -> 'a'|'b'|'c' needs 2 cuts for s[0..=2])
                dp[i] = i as i32; 
                for j in 0..i {
                    // If s[j+1..=i] is a palindrome, we can make a cut after s[j]
                    // and then add 1 cut to the minimum cuts for s[0..=j]
                    if is_palindrome[j + 1][i] {
                        dp[i] = dp[i].min(dp[j] + 1);
                    }
                }
            }
        }

        dp[n - 1]
    }
}