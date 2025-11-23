struct Solution;

impl Solution {
    pub fn next_greater_elements(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        if n == 0 {
            return Vec::new();
        }

        let mut ans = vec![-1; n];
        let mut stack: Vec<usize> = Vec::new(); // Stores indices

        // Iterate twice to handle the circular nature of the array.
        // The loop effectively processes a doubled array (nums + nums).
        // For i < n, we are processing the original array elements and pushing their indices to the stack.
        // For i >= n, we are processing the "second copy" of the array, which helps find
        // next greater elements for those elements in the stack that haven't found their NGE yet
        // by looking at elements that wrap around from the beginning of the original array.
        for i in 0..(2 * n) {
            let current_idx = i % n;
            let current_val = nums[current_idx];

            // While the stack is not empty and the element at the index on top of the stack
            // is less than the current value, it means current_val is the next greater element
            // for the element at stack.last().
            while let Some(&top_idx) = stack.last() {
                if nums[top_idx] < current_val {
                    ans[top_idx] = current_val;
                    stack.pop();
                } else {
                    // If nums[top_idx] >= current_val, then current_val cannot be
                    // the NGE for top_idx (or any element below it in the stack),
                    // so we break and push current_idx.
                    break;
                }
            }

            // Only push indices from the first pass (original array) to the stack.
            // This ensures that `ans` is only filled for original indices and prevents
            // the stack from growing indefinitely with duplicate indices from the "second pass"
            // that don't correspond to the original `ans` array.
            if i < n {
                stack.push(current_idx);
            }
        }

        ans
    }
}