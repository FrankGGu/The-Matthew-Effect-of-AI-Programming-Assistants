impl Solution {
    pub fn k_increasing(arr: Vec<i32>, k: i32) -> i32 {
        let n = arr.len();
        let k_usize = k as usize;
        let mut total_operations = 0;

        for i in 0..k_usize {
            let mut subsequence = Vec::new();
            let mut current_idx = i;
            while current_idx < n {
                subsequence.push(arr[current_idx]);
                current_idx += k_usize;
            }

            let lnds_len = Self::longest_non_decreasing_subsequence(&subsequence);
            total_operations += (subsequence.len() - lnds_len) as i32;
        }

        total_operations
    }

    fn longest_non_decreasing_subsequence(nums: &[i32]) -> usize {
        if nums.is_empty() {
            return 0;
        }

        let mut tails = Vec::new();
        for &num in nums {
            // Find the index `idx` such that `tails[idx]` is the first element
            // strictly greater than `num`.
            // `partition_point` returns the index of the first element for which the predicate is true.
            // Here, the predicate is `x <= num`. We want the first `x` for which `x > num`.
            // So, `idx` will be the index of the first element in `tails` that is strictly greater than `num`.
            let idx = tails.partition_point(|&x| x <= num);

            if idx == tails.len() {
                // `num` is greater than or equal to all elements in `tails`,
                // so it extends the longest non-decreasing subsequence.
                tails.push(num);
            } else {
                // `num` can replace `tails[idx]` to form a non-decreasing subsequence
                // of the same length but with a smaller ending element,
                // which is better for future elements.
                tails[idx] = num;
            }
        }
        tails.len()
    }
}