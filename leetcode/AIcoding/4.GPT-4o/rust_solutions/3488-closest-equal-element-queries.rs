impl Solution {
    pub fn closest_equal_queries(nums: Vec<i32>, queries: Vec<i32>) -> Vec<i32> {
        let mut index_map = std::collections::HashMap::new();
        let mut result = Vec::new();

        for (i, &num) in nums.iter().enumerate() {
            index_map.entry(num).or_insert(vec![]).push(i);
        }

        for query in queries {
            if let Some(indices) = index_map.get(&query) {
                let closest_index = indices.iter().copied().min_by_key(|&index| (index as i32 - 0).abs()).unwrap();
                result.push(closest_index as i32);
            } else {
                result.push(-1);
            }
        }

        result
    }
}