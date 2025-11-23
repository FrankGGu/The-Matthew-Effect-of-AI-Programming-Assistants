impl Solution {
    pub fn max_palindrome_product(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut max_len = 0;
        let mut palindromes = Vec::new();

        for i in 0..n {
            let mut l = i;
            let mut r = i;
            while l < n && r < n && s_bytes[l] == s_bytes[r] {
                palindromes.push(r - l + 1);
                l -= 1;
                r += 1;
            }
            l = i;
            r = i + 1;
            while l < n && r < n && s_bytes[l] == s_bytes[r] {
                palindromes.push(r - l + 1);
                l -= 1;
                r += 1;
            }
        }

        if palindromes.len() < 2 {
            return 0;
        }

        palindromes.sort_by(|a, b| b.cmp(a));
        (palindromes[0] * palindromes[1]) as i32
    }
}