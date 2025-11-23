impl Solution {
    pub fn max_diff(num: i32) -> i32 {
        let s = num.to_string();
        let mut max_num = s.clone();
        let mut min_num = s.clone();

        for i in 0..s.len() {
            let c = s.chars().nth(i).unwrap();
            let mut found_max = false;
            let mut found_min = false;

            if max_num.chars().nth(i).unwrap() != '9' {
                found_max = true;
                let replace_with = '9';
                max_num = max_num.replace(c, &replace_with.to_string());
            }

            if min_num.chars().nth(i).unwrap() != '0' {
                if min_num.chars().nth(0).unwrap() == c {
                    found_min = true;
                    let replace_with = '0';
                    min_num = min_num.replace(c, &replace_with.to_string());
                } else if i == 0 {
                    found_min = true;
                    let replace_with = '1';
                    min_num = min_num.replace(c, &replace_with.to_string());
                } else {
                    if min_num.chars().nth(i).unwrap() != '0' {
                        found_min = true;
                        let replace_with = '0';
                        min_num = min_num.replace(c, &replace_with.to_string());
                    }
                }
            }

            if found_max {
                break;
            }

            if found_min {
                break;
            }
        }

        max_num.parse::<i32>().unwrap() - min_num.parse::<i32>().unwrap()
    }
}