impl Solution {
    pub fn count_houses(dist: Vec<i32>, radius: i32) -> Vec<i32> {
        let n = dist.len();
        let mut result = vec![0; n];
        let mut prefix_sum = vec![0; n + 1];

        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + dist[i];
        }

        for i in 0..n {
            let left_bound = dist[i] - radius;
            let right_bound = dist[i] + radius;

            let left_index = match prefix_sum.binary_search(&left_bound) {
                Ok(x) => x,
                Err(x) => x,
            };
            let right_index = match prefix_sum.binary_search(&right_bound) {
                Ok(x) => x + 1,
                Err(x) => x,
            };

            result[i] = (right_index - left_index) as i32;
        }

        result
    }
}