struct Solution;

impl Solution {
    pub fn count_and_say(n: i32) -> String {
        if n == 1 {
            return "1".to_string();
        }

        let prev_str = Self::count_and_say(n - 1);
        let mut result = String::new();
        let chars: Vec<char> = prev_str.chars().collect();
        let mut i = 0;

        while i < chars.len() {
            let current_char = chars[i];
            let mut count = 0;
            let mut j = i;

            while j < chars.len() && chars[j] == current_char {
                count += 1;
                j += 1;
            }

            result.push_str(&count.to_string());
            result.push(current_char);
            i = j;
        }

        result
    }
}