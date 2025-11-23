impl Solution {
    pub fn count_largest_group(n: i32) -> i32 {
        use std::collections::HashMap;

        let mut group_sizes = HashMap::new();

        for i in 1..=n {
            let sum_of_digits = i.to_string().chars().map(|c| c.to_digit(10).unwrap()).sum::<u32>();
            *group_sizes.entry(sum_of_digits).or_insert(0) += 1;
        }

        let max_size = group_sizes.values().cloned().max().unwrap_or(0);
        group_sizes.values().filter(|&&size| size == max_size).count() as i32
    }
}