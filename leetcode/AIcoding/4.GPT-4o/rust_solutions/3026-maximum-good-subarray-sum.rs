impl Solution {
    pub fn maximum_good(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_sum = 0;

        for mask in 0..1 << n {
            let mut sum = 0;
            let mut valid = true;

            for i in 0..n {
                if (mask >> i) & 1 == 1 {
                    sum += nums[i];
                    if nums[i] == 0 {
                        valid = false;
                        break;
                    }
                } else if nums[i] == 1 {
                    valid = false;
                    break;
                }
            }

            if valid {
                max_sum = max_sum.max(sum);
            }
        }

        max_sum
    }
}