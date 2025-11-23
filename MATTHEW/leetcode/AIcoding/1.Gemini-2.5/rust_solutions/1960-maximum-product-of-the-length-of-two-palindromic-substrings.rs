impl Solution {
    pub fn max_product(s: String) -> i64 {
        let n = s.len();
        if n < 2 {
            return 0;
        }

        let chars: Vec<char> = s.chars().collect();

        let mut is_palindrome = vec![vec![false; n]; n];

        for i in 0..n {
            is_palindrome[i][i] = true;
        }

        for i in 0..n - 1 {
            if chars[i] == chars[i+1] {
                is_palindrome[i][i+1] = true;
            }
        }

        for len in 3..=n {
            for i in 0..=(n - len) {
                let j = i + len - 1;
                if chars[i] == chars[j] && is_palindrome[i+1][j-1] {
                    is_palindrome[i][j] = true;
                }
            }
        }

        let mut max_pal_len_prefix = vec![0; n];
        let mut current_max_prefix_len = 0;
        for k in 0..n {
            for i in 0..=k {
                if is_palindrome[i][k] {
                    current_max_prefix_len = current_max_prefix_len.max(k - i + 1);
                }
            }
            max_pal_len_prefix[k] = current_max_prefix_len;
        }

        let mut max_pal_len_suffix = vec![0; n];
        let mut current_max_suffix_len = 0;
        for k in (0..n).rev() {
            for j in k..n {
                if is_palindrome[k][j] {
                    current_max_suffix_len = current_max_suffix_len.max(j - k + 1);
                }
            }
            max_pal_len_suffix[k] = current_max_suffix_len;
        }

        let mut max_product = 0;

        for i in 0..n - 1 {
            let len1 = max_pal_len_prefix[i];
            let len2 = max_pal_len_suffix[i+1];
            max_product = max_product.max(len1 as i64 * len2 as i64);
        }

        max_product
    }
}