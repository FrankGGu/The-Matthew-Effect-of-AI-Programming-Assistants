use std::collections::HashSet;

impl Solution {
    pub fn minimum_sum(n: i32, k: i32) -> i32 {
        let mut current_sum: i32 = 0;
        let mut count: i32 = 0;
        let mut chosen_numbers: HashSet<i32> = HashSet::new();
        let mut num: i32 = 1;

        while count < n {
            if !chosen_numbers.contains(&(k - num)) {
                current_sum += num;
                chosen_numbers.insert(num);
                count += 1;
            }
            num += 1;
        }

        current_sum
    }
}