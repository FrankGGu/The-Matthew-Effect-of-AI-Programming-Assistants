impl Solution {
    pub fn split_array(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n < 7 {
            return false;
        }

        let mut sum = vec![0; n + 1];
        for i in 0..n {
            sum[i + 1] = sum[i] + nums[i];
        }

        for j in 3..n - 3 {
            let sum_j = sum[j];
            let mut i_set = std::collections::HashSet::new();
            for i in 1..j - 1 {
                if sum[i] == sum_j - sum[i + 1] {
                    i_set.insert(i);
                }
            }

            let sum_j_1 = sum[j + 1];
            for k in j + 2..n - 1 {
                if sum[k] - sum_j_1 == sum[n] - sum[k + 1] {
                    for &i in &i_set {
                        if sum[i] == sum[k] - sum_j_1 {
                            return true;
                        }
                    }
                }
            }
        }

        false
    }
}