impl Solution {
    pub fn can_construct(s: String, k: i32) -> bool {
        let n = s.len() as i32;

        // Condition 1: The number of palindromes (k) cannot exceed the total number of characters (n).
        // Each palindrome must contain at least one character.
        if k > n {
            return false;
        }

        // Count character frequencies
        let mut counts = [0; 26];
        for c in s.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        // Count characters that appear an odd number of times
        let mut odd_freq_chars = 0;
        for &count in counts.iter() {
            if count % 2 != 0 {
                odd_freq_chars += 1;
            }
        }

        // Condition 2: The number of palindromes (k) must be at least the count of characters
        // with odd frequencies (odd_freq_chars).
        // Each character with an odd frequency must be the 'center' of its own palindrome
        // or contribute to the odd count of a palindrome. Therefore, we need at least
        // 'odd_freq_chars' palindromes to accommodate these characters.
        if odd_freq_chars > k {
            return false;
        }

        // If both conditions are met, it is possible to construct k palindrome strings.
        // We have enough palindromes (k) to house all the odd-frequency characters (odd_freq_chars).
        // The remaining characters (n - odd_freq_chars) are all available in pairs.
        // These pairs can be distributed among any of the k palindromes without affecting
        // their palindrome property or the odd/even counts.
        true
    }
}