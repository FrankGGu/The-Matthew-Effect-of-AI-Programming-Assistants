impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn total_fruits(fruits: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut left = 0;
        let mut max = 0;

        for right in 0..fruits.len() {
            let fruit = fruits[right];
            *count.entry(fruit).or_insert(0) += 1;

            while count.len() > 2 {
                let left_fruit = fruits[left];
                *count.get_mut(&left_fruit).unwrap() -= 1;
                if *count.get_mut(&left_fruit).unwrap() == 0 {
                    count.remove(&left_fruit);
                }
                left += 1;
            }

            max = max.max(right - left + 1);
        }

        max as i32
    }
}
}