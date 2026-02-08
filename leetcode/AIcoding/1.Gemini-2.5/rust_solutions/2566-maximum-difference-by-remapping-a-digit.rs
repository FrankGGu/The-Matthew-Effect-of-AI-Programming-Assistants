impl Solution {
    pub fn max_diff(num: i32) -> i32 {
        let s = num.to_string();
        let chars: Vec<char> = s.chars().collect();

        let mut max_chars = chars.clone();
        let mut digit_to_replace_for_max: Option<char> = None;
        for &c in max_chars.iter() {
            if c != '9' {
                digit_to_replace_for_max = Some(c);
                break;
            }
        }

        if let Some(d) = digit_to_replace_for_max {
            for i in 0..max_chars.len() {
                if max_chars[i] == d {
                    max_chars[i] = '9';
                }
            }
        }
        let max_num_str: String = max_chars.into_iter().collect();
        let max_val = max_num_str.parse::<i32>().unwrap();

        let mut min_chars = chars.clone();
        let mut digit_to_replace_for_min: Option<char> = None;
        for &c in min_chars.iter() {
            if c != '0' {
                digit_to_replace_for_min = Some(c);
                break;
            }
        }

        if let Some(d) = digit_to_replace_for_min {
            for i in 0..min_chars.len() {
                if min_chars[i] == d {
                    min_chars[i] = '0';
                }
            }
        }
        let min_num_str: String = min_chars.into_iter().collect();
        let min_val = min_num_str.parse::<i32>().unwrap();

        max_val - min_val
    }
}