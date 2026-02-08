impl Solution {
    pub fn reverse_vowels(s: String) -> String {
        let vowels: Vec<char> = vec!['a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'];
        let mut chars: Vec<char> = s.chars().collect();
        let mut left = 0;
        let mut right = chars.len() as i32 - 1;

        while left < right {
            while left < right && !vowels.contains(&chars[left as usize]) {
                left += 1;
            }
            while left < right && !vowels.contains(&chars[right as usize]) {
                right -= 1;
            }
            if left < right {
                chars.swap(left as usize, right as usize);
                left += 1;
                right -= 1;
            }
        }

        chars.into_iter().collect()
    }
}