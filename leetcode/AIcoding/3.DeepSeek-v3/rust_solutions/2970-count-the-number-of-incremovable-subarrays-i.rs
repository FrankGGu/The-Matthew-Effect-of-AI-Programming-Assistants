impl Solution {
    pub fn count_incremovable_subarrays(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;

        for i in 0..n {
            for j in i..n {
                let mut valid = true;
                let mut prev = -1;
                for k in 0..n {
                    if k >= i && k <= j {
                        continue;
                    }
                    if prev >= nums[k] {
                        valid = false;
                        break;
                    }
                    prev = nums[k];
                }
                if valid {
                    count += 1;
                }
            }
        }

        count
    }
}