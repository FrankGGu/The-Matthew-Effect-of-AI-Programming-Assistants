use std::collections::HashMap;

impl Solution {
    pub fn total_fruit(fruits: Vec<i32>) -> i32 {
        let mut max_fruits = 0;
        let mut window_start = 0;
        let mut fruit_count: HashMap<i32, i32> = HashMap::new();

        for window_end in 0..fruits.len() {
            let right_fruit = fruits[window_end];
            *fruit_count.entry(right_fruit).or_insert(0) += 1;

            while fruit_count.len() > 2 {
                let left_fruit = fruits[window_start];
                *fruit_count.entry(left_fruit).or_insert(0) -= 1;
                if fruit_count[&left_fruit] == 0 {
                    fruit_count.remove(&left_fruit);
                }
                window_start += 1;
            }

            max_fruits = max_fruits.max((window_end - window_start + 1) as i32);
        }

        max_fruits
    }
}