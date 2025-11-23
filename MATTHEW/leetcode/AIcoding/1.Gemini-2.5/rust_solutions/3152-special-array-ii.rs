impl Solution {
    pub fn is_array_special(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = nums.len();

        if n <= 1 {
            return queries.iter().map(|_| true).collect();
        }

        let mut prefix_breaks = vec![0; n];

        for i in 0..n - 1 {
            prefix_breaks[i + 1] = prefix_breaks[i];
            if (nums[i] & 1) == (nums[i + 1] & 1) {
                prefix_breaks[i + 1] += 1;
            }
        }

        let mut result = Vec::with_capacity(queries.len());
        for query in queries {
            let from = query[0] as usize;
            let to = query[1] as usize;

            // A subarray nums[from..to] is special if there are no adjacent pairs
            // (nums[j], nums[j+1]) with the same parity for j in [from, to-1].
            // The count of such pairs in this range is prefix_breaks[to] - prefix_breaks[from].
            // If this difference is 0, the subarray is special.
            result.push(prefix_breaks[to] - prefix_breaks[from] == 0);
        }

        result
    }
}