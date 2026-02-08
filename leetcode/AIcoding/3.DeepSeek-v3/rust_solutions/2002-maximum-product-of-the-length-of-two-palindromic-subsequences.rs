impl Solution {
    pub fn max_product(s: String) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut palindromes = vec![];

        for mask in 1..1 << n {
            let mut subseq = vec![];
            for i in 0..n {
                if mask & (1 << i) != 0 {
                    subseq.push(s[i]);
                }
            }
            if Self::is_palindrome(&subseq) {
                palindromes.push(mask);
            }
        }

        let mut max_product = 0;
        for i in 0..palindromes.len() {
            for j in i + 1..palindromes.len() {
                if palindromes[i] & palindromes[j] == 0 {
                    let len1 = palindromes[i].count_ones() as i32;
                    let len2 = palindromes[j].count_ones() as i32;
                    max_product = max_product.max(len1 * len2);
                }
            }
        }
        max_product
    }

    fn is_palindrome(s: &[u8]) -> bool {
        let n = s.len();
        for i in 0..n / 2 {
            if s[i] != s[n - 1 - i] {
                return false;
            }
        }
        true
    }
}