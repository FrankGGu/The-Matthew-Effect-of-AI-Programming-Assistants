impl Solution {
    pub fn make_largest_special(s: String) -> String {
        let mut subs: Vec<String> = Vec::new();
        let mut count = 0;
        let mut start = 0;
        for (i, c) in s.chars().enumerate() {
            if c == '1' {
                count += 1;
            } else {
                count -= 1;
            }
            if count == 0 {
                subs.push("1".to_string() + &Solution::make_largest_special(s[start + 1..i].to_string()) + "0");
                start = i + 1;
            }
        }
        subs.sort_by(|a, b| b.cmp(a));
        subs.join("")
    }
}