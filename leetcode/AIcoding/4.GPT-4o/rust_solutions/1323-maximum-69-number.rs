impl Solution {
    pub fn maximum_69_number (num: i32) -> i32 {
        let num_str = num.to_string();
        let mut result = num_str.clone();

        for c in num_str.chars() {
            if c == '6' {
                result.replace_range(result.find(c).unwrap()..result.find(c).unwrap() + 1, "9");
                break;
            }
        }

        result.parse::<i32>().unwrap()
    }
}