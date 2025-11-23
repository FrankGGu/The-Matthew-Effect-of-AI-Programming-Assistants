impl Solution {
    pub fn next_greater_elements(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut res = vec![-1; n];
        let mut stack = Vec::new();

        for i in 0..2 * n {
            let idx = i % n;
            while let Some(&top) = stack.last() {
                if nums[top] < nums[idx] {
                    res[top] = nums[idx];
                    stack.pop();
                } else {
                    break;
                }
            }
            if i < n {
                stack.push(idx);
            }
        }

        res
    }
}