struct Solution;

impl Solution {
    pub fn total_steps(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        // stack stores (value, steps_taken_by_this_element_to_be_removed)
        // The 'steps_taken_by_this_element_to_be_removed' for an element `num`
        // represents how many steps it takes for `num` to be removed by the first
        // larger element to its left that is still in the array.
        // This value is 0 if `num` is never removed by a left element.
        let mut stack: Vec<(i32, i32)> = Vec::with_capacity(n);
        let mut max_total_steps = 0;

        for num in nums {
            let mut current_element_steps = 0;

            // Pop elements from the stack that are less than or equal to the current 'num'.
            // These popped elements are "eaten" by 'num' (or by a larger element to the left of 'num'
            // that is still on the stack).
            // The 'current_element_steps' for 'num' accumulates the maximum steps taken by any
            // of the elements it "eats". This is because 'num' cannot be removed until all
            // elements to its immediate right that are smaller than it are removed.
            while let Some(&(prev_val, prev_steps)) = stack.last() {
                if prev_val <= num {
                    stack.pop();
                    current_element_steps = current_element_steps.max(prev_steps);
                } else {
                    // prev_val > num, so 'num' is smaller than the top of the stack.
                    // This 'prev_val' will be the element that eventually removes 'num'.
                    break;
                }
            }

            if stack.is_empty() {
                // If the stack is empty, 'num' is greater than all previous elements
                // or it's the very first element. It will not be removed by any element
                // to its left. So, its removal steps count is 0.
                stack.push((num, 0));
            } else {
                // The top of the stack (prev_val) is greater than 'num'.
                // This means 'num' will be removed by 'prev_val'.
                // 'num' will be removed one step *after* all elements it "ate" are removed.
                // So, its removal steps count is 1 + current_element_steps.
                current_element_steps += 1;
                max_total_steps = max_total_steps.max(current_element_steps);
                stack.push((num, current_element_steps));
            }
        }

        max_total_steps
    }
}