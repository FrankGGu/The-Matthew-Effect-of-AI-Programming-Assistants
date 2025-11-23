impl Solution {
    pub fn punishment_number(n: i32) -> i32 {
        let mut res = 0;
        for i in 1..=n {
            let square = i * i;
            if Self::can_partition(&square.to_string(), i) {
                res += square;
            }
        }
        res
    }

    fn can_partition(s: &str, target: i32) -> bool {
        if s.is_empty() {
            return target == 0;
        }
        if target < 0 {
            return false;
        }
        for i in 1..=s.len() {
            let num = s[..i].parse::<i32>().unwrap();
            if Self::can_partition(&s[i..], target - num) {
                return true;
            }
        }
        false
    }
}