impl Solution {
    pub fn max_difference(num: i32) -> i32 {
        let str_num = num.to_string();
        let mut min_num = str_num.clone();
        let mut max_num = str_num.clone();

        for (i, c) in str_num.chars().enumerate() {
            if c != '9' {
                max_num.replace_range(i..=i, "9");
                break;
            }
        }

        for (i, c) in str_num.chars().enumerate() {
            if c != '0' && (i != 0 || c != '1') {
                min_num.replace_range(i..=i, "0");
                break;
            } else if c == '1' {
                min_num.replace_range(i..=i, "1");
                break;
            }
        }

        let max_value = max_num.parse::<i32>().unwrap();
        let min_value = min_num.parse::<i32>().unwrap();

        max_value - min_value
    }
}