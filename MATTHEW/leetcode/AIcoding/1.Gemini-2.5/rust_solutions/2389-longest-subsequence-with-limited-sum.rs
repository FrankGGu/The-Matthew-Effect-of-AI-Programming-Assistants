impl Solution {
    pub fn answer_queries(mut nums: Vec<i32>, queries: Vec<i32>) -> Vec<i32> {
        nums.sort_unstable();

        let n = nums.len();
        let mut prefix_sums = vec![0; n];
        if n > 0 {
            prefix_sums[0] = nums[0];
            for i in 1..n {
                prefix_sums[i] = prefix_sums[i - 1] + nums[i];
            }
        }

        let mut ans = Vec::with_capacity(queries.len());
        for query in queries {
            let length = prefix_sums.partition_point(|&s| s <= query);
            ans.push(length as i32);
        }

        ans
    }
}