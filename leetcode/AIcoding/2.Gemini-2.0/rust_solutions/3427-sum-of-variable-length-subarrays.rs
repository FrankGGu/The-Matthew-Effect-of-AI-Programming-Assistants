impl Solution {
    pub fn sum_of_variable_length_subarrays(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i64> {
        let n = nums.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }

        let mut result = Vec::new();
        for query in queries {
            let l = query[0] as usize;
            let r = query[1] as usize;
            let k = query[2] as usize;

            let mut sum = 0;
            for i in 0..=(n - k) {
                let subarray_sum = prefix_sum[i + k] - prefix_sum[i];
                if i + 1 >= l && i + k <= r {
                    sum += subarray_sum;
                }
            }
            result.push(sum);
        }

        result
    }
}