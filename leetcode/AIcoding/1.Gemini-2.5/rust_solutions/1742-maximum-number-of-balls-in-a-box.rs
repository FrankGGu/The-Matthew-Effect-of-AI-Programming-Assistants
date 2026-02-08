impl Solution {
    pub fn count_balls(low_limit: i32, high_limit: i32) -> i32 {
        let mut box_counts = vec![0; 46]; // Max sum of digits for 99999 is 45 (9*5). So 46 is enough for indices 0-45.
        let mut max_balls = 0;

        for num in low_limit..=high_limit {
            let mut sum_digits = 0;
            let mut temp_num = num;
            while temp_num > 0 {
                sum_digits += temp_num % 10;
                temp_num /= 10;
            }
            box_counts[sum_digits as usize] += 1;
        }

        for count in box_counts {
            if count > max_balls {
                max_balls = count;
            }
        }

        max_balls
    }
}