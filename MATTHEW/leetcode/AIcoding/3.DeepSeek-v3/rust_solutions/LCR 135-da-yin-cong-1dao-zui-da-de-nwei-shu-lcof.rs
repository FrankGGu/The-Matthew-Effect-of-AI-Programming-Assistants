impl Solution {
    pub fn count_and_say(n: i32) -> String {
        if n == 1 {
            return "1".to_string();
        }
        let prev = Solution::count_and_say(n - 1);
        let mut res = String::new();
        let mut count = 1;
        let mut chars = prev.chars().collect::<Vec<_>>();
        for i in 1..chars.len() {
            if chars[i] == chars[i - 1] {
                count += 1;
            } else {
                res.push_str(&count.to_string());
                res.push(chars[i - 1]);
                count = 1;
            }
        }
        res.push_str(&count.to_string());
        res.push(chars[chars.len() - 1]);
        res
    }
}