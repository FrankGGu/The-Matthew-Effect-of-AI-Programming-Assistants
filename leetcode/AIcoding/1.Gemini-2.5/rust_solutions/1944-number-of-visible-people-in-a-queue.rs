struct Solution;

impl Solution {
    pub fn can_see_persons(heights: Vec<i32>) -> Vec<i32> {
        let n = heights.len();
        let mut ans = vec![0; n];
        let mut stack: Vec<usize> = Vec::new(); // Stores indices of people, maintaining strictly decreasing heights from bottom to top

        // Iterate from right to left
        for i in (0..n).rev() {
            let current_height = heights[i];
            let mut count = 0;

            // Pop people from the stack who are shorter than the current person.
            // These people are seen by the current person.
            // They are also blocked by the current person for any people further to the left.
            while let Some(&top_idx) = stack.last() {
                if heights[top_idx] < current_height {
                    stack.pop();
                    count += 1;
                } else {
                    // The person on top of the stack is taller than or equal to the current person.
                    // The current person can see this taller/equal person.
                    // This taller/equal person then blocks the view to anyone behind them.
                    // So, we count them and stop looking further right.
                    count += 1;
                    break;
                }
            }
            ans[i] = count;

            // After calculating the count for the current person, we need to update the stack.
            // Any person in the stack whose height is less than or equal to the current person's height
            // is now blocked by the current person for any people further to the left.
            // So, pop them to maintain the strictly decreasing height property of the stack.
            while let Some(&top_idx) = stack.last() {
                if heights[top_idx] <= current_height {
                    stack.pop();
                } else {
                    break;
                }
            }
            // Push the current person's index onto the stack.
            // The stack now contains indices of people to the right of 'i'
            // who are taller than 'i' and are potentially visible to people to the left of 'i'.
            stack.push(i);
        }

        ans
    }
}