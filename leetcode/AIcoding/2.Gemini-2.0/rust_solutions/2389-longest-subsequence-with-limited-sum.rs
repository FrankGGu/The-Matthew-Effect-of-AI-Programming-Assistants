impl Solution {
    pub fn answer_queries(nums: Vec<i32>, queries: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        nums.sort();
        let mut prefix_sums = vec![0; nums.len()];
        prefix_sums[0] = nums[0];
        for i in 1..nums.len() {
            prefix_sums[i] = prefix_sums[i - 1] + nums[i];
        }

        let mut result = Vec::new();
        for &query in &queries {
            let mut count = 0;
            for &sum in &prefix_sums {
                if sum <= query {
                    count += 1;
                } else {
                    break;
                }
            }
            result.push(count as i32);
        }

        result
    }
}