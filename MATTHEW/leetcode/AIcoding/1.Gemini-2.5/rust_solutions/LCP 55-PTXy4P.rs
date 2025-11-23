use std::collections::HashMap;

impl Solution {
    pub fn total_fruit(fruits: Vec<i32>) -> i32 {
        let n = fruits.len();
        let mut max_fruits = 0;
        let mut left = 0;
        let mut fruit_counts: HashMap<i32, i32> = HashMap::new();

        for right in 0..n {
            *fruit_counts.entry(fruits[right]).or_insert(0) += 1;

            while fruit_counts.len() > 2 {
                let left_fruit = fruits[left];
                *fruit_counts.get_mut(&left_fruit).unwrap() -= 1;
                if *fruit_counts.get(&left_fruit).unwrap() == 0 {
                    fruit_counts.remove(&left_fruit);
                }
                left += 1;
            }

            max_fruits = max_fruits.max((right - left + 1) as i32);
        }

        max_fruits
    }
}