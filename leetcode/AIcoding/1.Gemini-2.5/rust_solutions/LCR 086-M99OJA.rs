struct Solution;

impl Solution {
    pub fn partition(s: String) -> Vec<Vec<String>> {
        let mut result: Vec<Vec<String>> = Vec::new();
        let mut current_partition: Vec<String> = Vec::new();
        let s_chars: Vec<char> = s.chars().collect();

        Self::backtrack(&s_chars, 0, &mut current_partition, &mut result);

        result
    }

    fn is_palindrome(chars: &[char]) -> bool {
        let mut left = 0;
        let mut right = chars.len();
        if right == 0 {
            return true;
        }
        right -= 1;

        while left < right {
            if chars[left] != chars[right] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }

    fn backtrack(
        s_chars: &[char],
        start_index: usize,
        current_partition: &mut Vec<String>,
        result: &mut Vec<Vec<String>>,
    ) {
        if start_index == s_chars.len() {
            result.push(current_partition.clone());
            return;
        }

        for i in start_index..s_chars.len() {
            let substring_slice = &s_chars[start_index..=i];
            if Self::is_palindrome(substring_slice) {
                current_partition.push(substring_slice.iter().collect());
                Self::backtrack(s_chars, i + 1, current_partition, result);
                current_partition.pop();
            }
        }
    }
}