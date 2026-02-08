impl Solution {
    pub fn mark_elements(nums: Vec<i32>, queries: Vec<i32>) -> Vec<i32> {
        let mut marked = vec![0; nums.len()];
        let mut result = vec![-1; queries.len()];
        let mut num_to_index = std::collections::HashMap::new();

        for (i, &num) in nums.iter().enumerate() {
            num_to_index.insert(num, i);
        }

        for (i, &query) in queries.iter().enumerate() {
            if let Some(&index) = num_to_index.get(&query) {
                marked[index] = 1;
                result[i] = query;
            }
        }

        result
    }
}