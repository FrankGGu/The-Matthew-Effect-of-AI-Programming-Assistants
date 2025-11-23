impl Solution {
    pub fn total_fruit(fruits: Vec<i32>) -> i32 {
        let mut max_fruits = 0;
        let mut left = 0;
        let mut fruit_count = std::collections::HashMap::new();
        let mut distinct_fruits = 0;

        for right in 0..fruits.len() {
            let fruit = fruits[right];
            if !fruit_count.contains_key(&fruit) {
                distinct_fruits += 1;
            }
            *fruit_count.entry(fruit).or_insert(0) += 1;

            while distinct_fruits > 2 {
                let left_fruit = fruits[left];
                *fruit_count.get_mut(&left_fruit).unwrap() -= 1;
                if fruit_count[&left_fruit] == 0 {
                    fruit_count.remove(&left_fruit);
                    distinct_fruits -= 1;
                }
                left += 1;
            }
            max_fruits = max_fruits.max((right - left + 1) as i32);
        }

        max_fruits
    }
}