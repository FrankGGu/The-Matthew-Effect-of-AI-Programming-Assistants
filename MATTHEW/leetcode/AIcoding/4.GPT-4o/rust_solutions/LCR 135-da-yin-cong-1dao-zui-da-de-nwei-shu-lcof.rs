impl Solution {
    pub fn count_and_say(n: i32) -> String {
        let mut result = String::from("1");
        for _ in 1..n {
            let mut next_result = String::new();
            let mut count = 1;
            let chars: Vec<char> = result.chars().collect();
            for i in 1..chars.len() {
                if chars[i] == chars[i - 1] {
                    count += 1;
                } else {
                    next_result.push_str(&count.to_string());
                    next_result.push(chars[i - 1]);
                    count = 1;
                }
            }
            next_result.push_str(&count.to_string());
            next_result.push(chars[chars.len() - 1]);
            result = next_result;
        }
        result
    }
}