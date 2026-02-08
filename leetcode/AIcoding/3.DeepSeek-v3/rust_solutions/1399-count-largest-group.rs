impl Solution {
    pub fn count_largest_group(n: i32) -> i32 {
        use std::collections::HashMap;
        let mut map = HashMap::new();

        for i in 1..=n {
            let mut num = i;
            let mut sum = 0;
            while num > 0 {
                sum += num % 10;
                num /= 10;
            }
            *map.entry(sum).or_insert(0) += 1;
        }

        let max = map.values().max().unwrap_or(&0);
        map.values().filter(|&v| v == max).count() as i32
    }
}