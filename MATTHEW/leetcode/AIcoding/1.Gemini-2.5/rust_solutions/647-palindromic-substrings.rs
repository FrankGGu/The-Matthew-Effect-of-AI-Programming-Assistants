impl Solution {
    pub fn count_substrings(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        let chars: Vec<char> = s.chars().collect();
        let mut count = 0;

        for i in 0..n {
            // Odd length palindromes, with chars[i] as the center
            let mut l = i as isize;
            let mut r = i as isize;
            while l >= 0 && r < n as isize && chars[l as usize] == chars[r as usize] {
                count += 1;
                l -= 1;
                r += 1;
            }

            // Even length palindromes, with chars[i] and chars[i+1] as the center
            let mut l = i as isize;
            let mut r = (i + 1) as isize;
            while l >= 0 && r < n as isize && chars[l as usize] == chars[r as usize] {
                count += 1;
                l -= 1;
                r += 1;
            }
        }

        count
    }
}