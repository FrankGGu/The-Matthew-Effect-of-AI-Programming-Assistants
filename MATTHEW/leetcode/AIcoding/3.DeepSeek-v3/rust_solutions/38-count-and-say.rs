impl Solution {
    pub fn count_and_say(n: i32) -> String {
        if n == 1 {
            return "1".to_string();
        }
        let prev = Solution::count_and_say(n - 1);
        let mut res = String::new();
        let mut chars = prev.chars().peekable();
        while let Some(c) = chars.next() {
            let mut count = 1;
            while let Some(&next) = chars.peek() {
                if next == c {
                    count += 1;
                    chars.next();
                } else {
                    break;
                }
            }
            res.push_str(&count.to_string());
            res.push(c);
        }
        res
    }
}