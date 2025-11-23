impl Solution {
    pub fn max_diff(num: i32) -> i32 {
        let s = num.to_string();
        let mut max_s = s.clone();
        let mut min_s = s.clone();

        for i in 0..s.len() {
            let c = s.chars().nth(i).unwrap();
            if c != '9' {
                let replace_char = c;
                let replace_with = '9';
                max_s = max_s.replace(replace_char, &replace_with.to_string());
                break;
            }
        }

        let first_char = s.chars().nth(0).unwrap();
        if first_char != '1' {
            min_s = min_s.replace(first_char, "1");
        } else {
            for i in 1..s.len() {
                let c = s.chars().nth(i).unwrap();
                if c != '0' && c != '1' {
                    min_s = min_s.replace(c, "0");
                    break;
                }
            }
        }

        max_s.parse::<i32>().unwrap() - min_s.parse::<i32>().unwrap()
    }
}