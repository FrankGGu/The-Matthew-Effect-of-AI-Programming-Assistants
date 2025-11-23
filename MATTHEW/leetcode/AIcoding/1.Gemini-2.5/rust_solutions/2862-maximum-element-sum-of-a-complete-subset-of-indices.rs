impl Solution {
    pub fn maximum_element_sum(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut max_sum: i64 = 0;

        for i_1_based in 1..=n {
            let mut current_subset_sum: i64 = 0;
            let mut k: usize = 1;

            loop {
                let j_1_based = i_1_based * k * k;

                if j_1_based > n {
                    break;
                }

                let j_0_based = j_1_based - 1;
                current_subset_sum += nums[j_0_based] as i64;

                k += 1;
            }
            max_sum = max_sum.max(current_subset_sum);
        }
        max_sum
    }
}