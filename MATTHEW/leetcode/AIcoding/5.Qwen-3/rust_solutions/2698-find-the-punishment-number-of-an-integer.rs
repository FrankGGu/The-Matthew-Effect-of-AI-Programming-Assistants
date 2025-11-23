struct Solution;

impl Solution {
    pub fn punishment_number(n: i32) -> i32 {
        fn is_valid(s: &str, target: i32) -> bool {
            if s.len() == 0 {
                return target == 0;
            }
            for i in 1..=s.len() {
                let part = &s[..i];
                let num = part.parse::<i32>().unwrap();
                if num > target {
                    break;
                }
                if is_valid(&s[i..], target - num) {
                    return true;
                }
            }
            false
        }

        let mut result = 0;
        for i in 1..=n {
            let s = i.to_string();
            if is_valid(&s, i) {
                result += i * i;
            }
        }
        result
    }
}