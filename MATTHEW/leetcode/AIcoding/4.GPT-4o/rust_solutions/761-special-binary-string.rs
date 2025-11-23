impl Solution {
    pub fn make_largest_special(s: String) -> String {
        let mut count = 0;
        let mut start = 0;
        let mut special_strings = Vec::new();

        for (i, c) in s.chars().enumerate() {
            count += if c == '1' { 1 } else { -1 };
            if count == 0 {
                special_strings.push("1".to_string() + &Self::make_largest_special(s[start + 2..i].to_string()) + "0");
                start = i + 1;
            }
        }

        special_strings.sort_unstable();
        special_strings.reverse();
        special_strings.join("")
    }
}