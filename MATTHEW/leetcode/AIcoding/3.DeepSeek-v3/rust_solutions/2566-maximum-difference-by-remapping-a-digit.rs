impl Solution {
    pub fn min_max_difference(num: i32) -> i32 {
        let s = num.to_string();
        let mut max_digit = None;
        let mut min_digit = None;

        for c in s.chars() {
            if c != '9' {
                max_digit = Some(c);
                break;
            }
        }

        for c in s.chars() {
            if c != '0' {
                min_digit = Some(c);
                break;
            }
        }

        let max_num = if let Some(d) = max_digit {
            s.chars().map(|c| if c == d { '9' } else { c }).collect::<String>().parse::<i32>().unwrap()
        } else {
            num
        };

        let min_num = if let Some(d) = min_digit {
            s.chars().map(|c| if c == d { '0' } else { c }).collect::<String>().parse::<i32>().unwrap()
        } else {
            num
        };

        max_num - min_num
    }
}