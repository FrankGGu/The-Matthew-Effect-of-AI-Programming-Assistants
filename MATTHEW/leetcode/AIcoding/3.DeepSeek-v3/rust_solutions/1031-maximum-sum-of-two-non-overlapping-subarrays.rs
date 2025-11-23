impl Solution {
    pub fn max_sum_two_no_overlap(nums: Vec<i32>, first_len: i32, second_len: i32) -> i32 {
        let n = nums.len();
        let first_len = first_len as usize;
        let second_len = second_len as usize;
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i];
        }

        let mut max_first = vec![0; n];
        let mut max_second = vec![0; n];

        let mut max_sum = 0;

        for i in first_len - 1..n {
            let current = prefix_sum[i + 1] - prefix_sum[i + 1 - first_len];
            if i == first_len - 1 {
                max_first[i] = current;
            } else {
                max_first[i] = max_first[i - 1].max(current);
            }
        }

        for i in second_len - 1..n {
            let current = prefix_sum[i + 1] - prefix_sum[i + 1 - second_len];
            if i == second_len - 1 {
                max_second[i] = current;
            } else {
                max_second[i] = max_second[i - 1].max(current);
            }
        }

        for i in first_len..n - second_len + 1 {
            let sum = max_first[i - 1] + (prefix_sum[i + second_len] - prefix_sum[i]);
            max_sum = max_sum.max(sum);
        }

        for i in second_len..n - first_len + 1 {
            let sum = max_second[i - 1] + (prefix_sum[i + first_len] - prefix_sum[i]);
            max_sum = max_sum.max(sum);
        }

        max_sum
    }
}