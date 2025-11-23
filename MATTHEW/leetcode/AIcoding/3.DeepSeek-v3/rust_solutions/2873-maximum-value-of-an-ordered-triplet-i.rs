impl Solution {
    pub fn maximum_triplet_value(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut max_val = 0;

        for i in 0..n {
            for j in i+1..n {
                for k in j+1..n {
                    let current = (nums[i] - nums[j]) as i64 * nums[k] as i64;
                    if current > max_val {
                        max_val = current;
                    }
                }
            }
        }

        max_val
    }
}