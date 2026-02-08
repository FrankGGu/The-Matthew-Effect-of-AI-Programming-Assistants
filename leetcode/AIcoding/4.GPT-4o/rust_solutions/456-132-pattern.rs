impl Solution {
    pub fn find132pattern(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n < 3 {
            return false;
        }

        let mut stack = Vec::new();
        let mut third = i32::MIN;

        for i in (0..n).rev() {
            if nums[i] < third {
                return true;
            }
            while let Some(&top) = stack.last() {
                if nums[i] > top {
                    third = top;
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(nums[i]);
        }

        false
    }
}