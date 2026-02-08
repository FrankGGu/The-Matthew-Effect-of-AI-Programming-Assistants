use std::collections::HashMap;

impl Solution {
    pub fn max_pair_sum(nums: Vec<i32>) -> i32 {
        let mut groups: HashMap<i32, Vec<i32>> = HashMap::new();

        for &num in &nums {
            let max_d = Self::get_max_digit(num);
            groups.entry(max_d).or_default().push(num);
        }

        let mut max_overall_sum = -1;

        for (_max_d, mut group) in groups {
            if group.len() >= 2 {
                group.sort_unstable_by(|a, b| b.cmp(a));
                let current_sum = group[0] + group[1];
                max_overall_sum = max_overall_sum.max(current_sum);
            }
        }

        max_overall_sum
    }

    fn get_max_digit(mut n: i32) -> i32 {
        let mut max_d = 0;
        while n > 0 {
            max_d = max_d.max(n % 10);
            n /= 10;
        }
        max_d
    }
}