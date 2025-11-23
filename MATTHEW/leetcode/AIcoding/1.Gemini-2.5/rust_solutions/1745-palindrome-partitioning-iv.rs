impl Solution {
    pub fn check_palindrome_partitioning(s: String) -> bool {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();

        let mut is_palindrome = vec![vec![false; n]; n];

        for i in 0..n {
            is_palindrome[i][i] = true;
        }

        for i in 0..n - 1 {
            if chars[i] == chars[i + 1] {
                is_palindrome[i][i + 1] = true;
            }
        }

        for len in 3..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                if chars[i] == chars[j] && is_palindrome[i + 1][j - 1] {
                    is_palindrome[i][j] = true;
                }
            }
        }

        for i in 1..n {
            if is_palindrome[0][i - 1] {
                for j in i + 1..n {
                    if is_palindrome[i][j - 1] {
                        if is_palindrome[j][n - 1] {
                            return true;
                        }
                    }
                }
            }
        }

        false
    }
}