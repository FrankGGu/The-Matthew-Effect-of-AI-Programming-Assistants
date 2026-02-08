use std::collections::HashMap;

impl Solution {
    pub fn relative_sort_array(arr1: Vec<i32>, arr2: Vec<i32>) -> Vec<i32> {
        let mut order_map = HashMap::new();
        for (i, &num) in arr2.iter().enumerate() {
            order_map.insert(num, i);
        }

        let mut arr1 = arr1;
        arr1.sort_by_key(|&num| {
            if let Some(&order) = order_map.get(&num) {
                (0, order)
            } else {
                (1, num)
            }
        });

        arr1
    }
}