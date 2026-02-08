impl Solution {
    pub fn minimum_division_operations(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        let mut operations: i64 = 0;
        let mut prev_val = nums[n - 1]; 

        for i in (0..n - 1).rev() {
            let current_val = nums[i];

            if current_val <= prev_val {
                prev_val = current_val;
            } else {
                let k = (current_val + prev_val - 1) / prev_val;

                operations += (k - 1) as i64;

                prev_val = current_val / k;
            }
        }

        operations
    }
}