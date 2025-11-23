impl Solution {
    pub fn count_substrings(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut count = 0;
        for i in 0..n {
            // Odd length palindromes
            let mut l = i as i32;
            let mut r = i as i32;
            while l >= 0 && r < n as i32 && s_bytes[l as usize] == s_bytes[r as usize] {
                count += 1;
                l -= 1;
                r += 1;
            }

            // Even length palindromes
            l = i as i32;
            r = (i + 1) as i32;
            while l >= 0 && r < n as i32 && s_bytes[l as usize] == s_bytes[r as usize] {
                count += 1;
                l -= 1;
                r += 1;
            }
        }
        count
    }
}