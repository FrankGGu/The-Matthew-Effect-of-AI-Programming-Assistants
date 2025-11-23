use std::collections::HashMap;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        if nums.len() <= 1 {
            return 0;
        }

        let mut even_counts = HashMap::new();
        let mut odd_counts = HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            if i % 2 == 0 {
                *even_counts.entry(num).or_insert(0) += 1;
            } else {
                *odd_counts.entry(num).or_insert(0) += 1;
            }
        }

        let even_max = Self::get_max_two(&even_counts);
        let odd_max = Self::get_max_two(&odd_counts);

        let even_len = (nums.len() + 1) / 2;
        let odd_len = nums.len() / 2;

        if even_max.0 != odd_max.0 {
            (even_len - even_max.1) + (odd_len - odd_max.1)
        } else {
            let option1 = (even_len - even_max.1) + (odd_len - if odd_max.2 == 0 { 0 } else { odd_max.2 });
            let option2 = (even_len - if even_max.2 == 0 { 0 } else { even_max.2 }) + (odd_len - odd_max.1);
            option1.min(option2)
        }
    }

    fn get_max_two(counts: &HashMap<i32, i32>) -> (i32, i32, i32) {
        let mut max1 = (0, 0);
        let mut max2 = (0, 0);

        for (&num, &count) in counts.iter() {
            if count > max1.1 {
                max2 = max1;
                max1 = (num, count);
            } else if count > max2.1 {
                max2 = (num, count);
            }
        }

        (max1.0, max1.1, max2.1)
    }
}