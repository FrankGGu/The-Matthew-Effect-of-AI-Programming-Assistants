use std::collections::HashMap;

impl Solution {
    pub fn relative_sort_array(arr1: Vec<i32>, arr2: Vec<i32>) -> Vec<i32> {
        let mut rank = HashMap::new();
        for (i, &num) in arr2.iter().enumerate() {
            rank.insert(num, i);
        }
        let mut arr1 = arr1;
        arr1.sort_by_key(|&num| {
            if rank.contains_key(&num) {
                (0, rank[&num])
            } else {
                (1, num)
            }
        });
        arr1
    }
}