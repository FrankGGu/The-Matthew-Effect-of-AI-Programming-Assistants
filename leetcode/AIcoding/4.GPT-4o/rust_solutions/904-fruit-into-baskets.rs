impl Solution {
    pub fn total_fruit(fruits: Vec<i32>) -> i32 {
        let mut count = std::collections::HashMap::new();
        let mut left = 0;
        let mut max_fruits = 0;

        for right in 0..fruits.len() {
            *count.entry(fruits[right]).or_insert(0) += 1;

            while count.len() > 2 {
                let left_fruit = fruits[left];
                if let Some(entry) = count.get_mut(&left_fruit) {
                    *entry -= 1;
                    if *entry == 0 {
                        count.remove(&left_fruit);
                    }
                }
                left += 1;
            }

            max_fruits = max_fruits.max(right - left + 1);
        }

        max_fruits
    }
}