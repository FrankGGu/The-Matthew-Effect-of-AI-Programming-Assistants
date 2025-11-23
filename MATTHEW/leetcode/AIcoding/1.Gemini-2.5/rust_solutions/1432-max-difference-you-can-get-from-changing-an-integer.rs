impl Solution {
    pub fn max_diff(num: i32) -> i32 {
        let s = num.to_string();

        // Calculate max_val
        let mut max_s = s.clone();
        let mut char_to_replace_for_max: Option<char> = None;
        for c in max_s.chars() {
            if c != '9' {
                char_to_replace_for_max = Some(c);
                break;
            }
        }
        if let Some(c) = char_to_replace_for_max {
            max_s = max_s.replace(c, '9');
        }
        let max_val = max_s.parse::<i32>().unwrap();

        // Calculate min_val
        let mut min_s = s.clone();
        let first_char = min_s.chars().next().unwrap();

        if first_char == '1' {
            // If the first digit is '1', we need to find a non-'0' and non-'1' digit to change to '0'.
            let mut char_to_replace_for_min: Option<char> = None;
            for c in min_s.chars() {
                if c != '0' && c != '1' {
                    char_to_replace_for_min = Some(c);
                    break;
                }
            }
            if let Some(c) = char_to_replace_for_min {
                min_s = min_s.replace(c, '0');
            }
        } else {
            // If the first digit is not '1', change all occurrences of the first digit to '1'.
            min_s = min_s.replace(first_char, '1');
        }
        let min_val = min_s.parse::<i32>().unwrap();

        max_val - min_val
    }
}