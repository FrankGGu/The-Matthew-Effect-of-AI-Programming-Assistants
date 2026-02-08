impl Solution {
    pub fn count_and_say(n: i32) -> String {
        if n == 1 {
            return "1".to_string();
        }

        let prev = Self::count_and_say(n - 1);
        let mut result = String::new();
        let mut count = 1;
        let mut current = prev.chars().nth(0).unwrap();

        for c in prev.chars().skip(1) {
            if c == current {
                count += 1;
            } else {
                result.push_str(&count.to_string());
                result.push(current);
                current = c;
                count = 1;
            }
        }

        result.push_str(&count.to_string());
        result.push(current);

        result
    }
}

struct Solution;