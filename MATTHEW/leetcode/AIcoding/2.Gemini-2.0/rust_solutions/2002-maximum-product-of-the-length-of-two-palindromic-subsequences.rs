impl Solution {
    pub fn max_product(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut palindromes = vec![0; 1 << n];

        for mask in 1..(1 << n) {
            let mut sub = Vec::new();
            for i in 0..n {
                if (mask >> i) & 1 == 1 {
                    sub.push(s_bytes[i]);
                }
            }

            let m = sub.len();
            let mut is_palindrome = true;
            for i in 0..m / 2 {
                if sub[i] != sub[m - 1 - i] {
                    is_palindrome = false;
                    break;
                }
            }

            if is_palindrome {
                palindromes[mask] = m as i32;
            }
        }

        let mut max_prod = 0;
        for mask1 in 1..(1 << n) {
            if palindromes[mask1] == 0 {
                continue;
            }

            for mask2 in 1..(1 << n) {
                if mask1 & mask2 == 0 && palindromes[mask2] != 0{
                    max_prod = max_prod.max(palindromes[mask1] * palindromes[mask2]);
                }
            }
        }

        max_prod
    }
}