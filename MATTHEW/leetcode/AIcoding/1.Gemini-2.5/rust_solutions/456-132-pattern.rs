impl Solution {
    pub fn find132pattern(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n < 3 {
            return false;
        }

        let mut stack: Vec<i32> = Vec::new();
        let mut k_val = i32::MIN;

        for i in (0..n).rev() {
            if nums[i] < k_val {
                return true;
            }
            while let Some(&top) = stack.last() {
                if nums[i] > top {
                    k_val = stack.pop().unwrap();
                } else {
                    break;
                }
            }
            stack.push(nums[i]);
        }

        false
    }
}