impl Solution {
    pub fn sum_of_distances(nums: Vec<i32>) -> Vec<i64> {
        let mut indices: std::collections::HashMap<i32, Vec<usize>> = std::collections::HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            indices.entry(num).or_insert(Vec::new()).push(i);
        }

        let mut result = vec![0; nums.len()];
        for (_, idx) in indices.iter() {
            let n = idx.len();
            let mut prefix_sum: i64 = 0;
            for i in 0..n {
                prefix_sum += idx[i] as i64;
            }

            for i in 0..n {
                let index = idx[i] as i64;
                let left_count = i as i64;
                let right_count = (n as i64) - (i as i64) - 1;

                let left_sum = (index * left_count) - (0..i).map(|j| idx[j] as i64).sum::<i64>();

                let right_sum = ((i + 1)..n).map(|j| idx[j] as i64).sum::<i64>() - (index * right_count);

                result[idx[i]] = left_sum + right_sum;
            }
        }

        result
    }
}