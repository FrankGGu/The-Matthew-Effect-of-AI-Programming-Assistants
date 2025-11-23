impl Solution {
    pub fn total_fruit(fruits: Vec<i32>) -> i32 {
        let mut max_fruits = 0;
        let mut basket = std::collections::HashMap::new();
        let mut left = 0;

        for right in 0..fruits.len() {
            *basket.entry(fruits[right]).or_insert(0) += 1;

            while basket.len() > 2 {
                *basket.get_mut(&fruits[left]).unwrap() -= 1;
                if basket[&fruits[left]] == 0 {
                    basket.remove(&fruits[left]);
                }
                left += 1;
            }

            max_fruits = max_fruits.max((right - left + 1) as i32);
        }

        max_fruits
    }
}