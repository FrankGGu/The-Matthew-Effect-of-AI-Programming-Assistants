impl Solution {
    pub fn next_greater_elements(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut res = vec![-1; n];
        let mut stack = Vec::new();

        for i in 0..2 * n {
            while let Some(&top) = stack.last() {
                if nums[top] < nums[i % n] {
                    res[top] = nums[i % n];
                    stack.pop();
                } else {
                    break;
                }
            }
            if i < n {
                stack.push(i);
            }
        }

        res
    }
}