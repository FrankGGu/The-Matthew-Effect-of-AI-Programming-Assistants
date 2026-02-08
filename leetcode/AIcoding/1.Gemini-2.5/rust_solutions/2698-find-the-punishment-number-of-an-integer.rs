impl Solution {
    pub fn punishment_number(n: i32) -> i32 {
        let mut total_punishment_sum = 0;

        for i in 1..=n {
            let square = i * i;
            let s = square.to_string();
            if Self::can_partition_sum(&s, 0, 0, i) {
                total_punishment_sum += i;
            }
        }
        total_punishment_sum
    }

    fn can_partition_sum(s: &str, index: usize, current_sum: i32, target: i32) -> bool {
        if current_sum > target {
            return false;
        }

        if index == s.len() {
            return current_sum == target;
        }

        for j in index..s.len() {
            let sub_str = &s[index..=j];
            let num = sub_str.parse::<i32>().unwrap();

            if Self::can_partition_sum(s, j + 1, current_sum + num, target) {
                return true;
            }
        }

        false
    }
}