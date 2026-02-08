use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn total_fruit(fruits: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut left = 0;
        let mut max_fruits = 0;

        for right in 0..fruits.len() {
            *count.entry(fruits[right]).or_insert(0) += 1;

            while count.len() > 2 {
                let fruit = fruits[left];
                *count.get_mut(&fruit).unwrap() -= 1;
                if count[&fruit] == 0 {
                    count.remove(&fruit);
                }
                left += 1;
            }

            max_fruits = max(max_fruits, (right - left + 1) as i32);
        }

        max_fruits
    }
}