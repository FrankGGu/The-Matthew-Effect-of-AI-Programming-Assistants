impl Solution {
    pub fn partition(s: String) -> Vec<Vec<String>> {
        let mut all_partitions: Vec<Vec<String>> = Vec::new();
        let mut current_partition: Vec<String> = Vec::new();
        let s_chars: Vec<char> = s.chars().collect();

        Self::backtrack(0, &mut current_partition, &mut all_partitions, &s_chars);

        all_partitions
    }

    fn is_palindrome(s: &[char]) -> bool {
        let mut left = 0;
        let mut right = s.len() as i32 - 1;
        while left < right {
            if s[left as usize] != s[right as usize] {
                return false;
            }
            left += 1;
            right -= 1;
        }
        true
    }

    fn backtrack(
        start_index: usize,
        current_partition: &mut Vec<String>,
        all_partitions: &mut Vec<Vec<String>>,
        s_chars: &[char],
    ) {
        if start_index == s_chars.len() {
            all_partitions.push(current_partition.clone());
            return;
        }

        for i in start_index..s_chars.len() {
            let sub_str_slice = &s_chars[start_index..=i];
            if Self::is_palindrome(sub_str_slice) {
                current_partition.push(sub_str_slice.iter().collect());
                Self::backtrack(i + 1, current_partition, all_partitions, s_chars);
                current_partition.pop();
            }
        }
    }
}