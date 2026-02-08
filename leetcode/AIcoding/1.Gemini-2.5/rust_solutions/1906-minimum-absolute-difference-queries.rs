impl Solution {
    pub fn min_absolute_difference_queries(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let max_val = 100;

        let mut prefix_counts = vec![vec![0; max_val + 1]; n + 1];
        for i in 0..n {
            for j in 1..=max_val {
                prefix_counts[i + 1][j] = prefix_counts[i][j];
            }
            prefix_counts[i + 1][nums[i] as usize] += 1;
        }

        let mut results = Vec::with_capacity(queries.len());

        for query in queries {
            let l = query[0] as usize;
            let r = query[1] as usize;

            let mut present_values = Vec::new();
            for val in 1..=max_val {
                let count = prefix_counts[r + 1][val] - prefix_counts[l][val];
                if count > 0 {
                    present_values.push(val as i32);
                }
            }

            if present_values.len() < 2 {
                results.push(-1);
            } else {
                let mut min_diff = max_val as i32;
                for i in 1..present_values.len() {
                    min_diff = min_diff.min(present_values[i] - present_values[i - 1]);
                }
                results.push(min_diff);
            }
        }

        results
    }
}