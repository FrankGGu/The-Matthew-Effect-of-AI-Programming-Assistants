impl Solution {
    pub fn answer_queries(mut nums: Vec<i32>, queries: Vec<i32>) -> Vec<i32> {
        nums.sort();
        let mut prefix = vec![0; nums.len() + 1];
        for i in 0..nums.len() {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        queries.into_iter().map(|q| {
            match prefix.binary_search(&q) {
                Ok(i) => i as i32,
                Err(i) => (i - 1) as i32,
            }
        }).collect()
    }
}