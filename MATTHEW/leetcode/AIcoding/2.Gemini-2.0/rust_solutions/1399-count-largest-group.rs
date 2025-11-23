use std::collections::HashMap;

impl Solution {
    pub fn count_largest_group(n: i32) -> i32 {
        let mut sum_count: HashMap<i32, i32> = HashMap::new();
        let mut max_count = 0;
        let mut result = 0;

        for i in 1..=n {
            let mut num = i;
            let mut sum = 0;
            while num > 0 {
                sum += num % 10;
                num /= 10;
            }

            let count = sum_count.entry(sum).or_insert(0);
            *count += 1;

            if *count > max_count {
                max_count = *count;
                result = 1;
            } else if *count == max_count {
                result += 1;
            }
        }

        result
    }
}