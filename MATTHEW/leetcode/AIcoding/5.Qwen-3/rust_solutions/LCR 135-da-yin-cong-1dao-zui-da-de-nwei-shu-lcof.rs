struct Solution {}

impl Solution {
    pub fn count_and_say(n: i32) -> String {
        if n == 1 {
            return "1".to_string();
        }

        let mut prev = "1".to_string();

        for _ in 2..=n {
            let mut curr = String::new();
            let mut i = 0;
            let chars: Vec<char> = prev.chars().collect();

            while i < chars.len() {
                let mut count = 1;
                while i + 1 < chars.len() && chars[i] == chars[i + 1] {
                    i += 1;
                    count += 1;
                }
                curr.push_str(&count.to_string());
                curr.push(chars[i]);
                i += 1;
            }

            prev = curr;
        }

        prev
    }
}