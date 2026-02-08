impl Solution {
    pub fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
        if heights.is_empty() {
            return 0;
        }

        let n = heights.len();
        let mut stack: Vec<usize> = Vec::new(); // Stores indices of bars
        let mut max_area = 0;

        for i in 0..n {
            // While the current bar is shorter than the bar at the top of the stack
            while let Some(&top_idx) = stack.last() {
                if heights[top_idx] >= heights[i] {
                    let h = heights[stack.pop().unwrap()]; // Pop the bar

                    // Calculate width for the popped bar
                    // If stack is empty, this bar extends from index 0 to i-1
                    // If stack is not empty, it extends from stack.last().unwrap() + 1 to i-1
                    let w = if stack.is_empty() {
                        i // Width is current index 'i'
                    } else {
                        i - stack.last().unwrap() - 1
                    };
                    max_area = max_area.max(h * w as i32);
                } else {
                    break; // Current bar is taller, push it
                }
            }
            stack.push(i); // Push current bar's index onto the stack
        }

        // Process remaining bars in the stack
        // These bars extend to the end of the histogram (index n-1)
        while let Some(top_idx) = stack.pop() {
            let h = heights[top_idx];

            // Calculate width for the popped bar
            // If stack is empty, this bar extends from index 0 to n-1
            // If stack is not empty, it extends from stack.last().unwrap() + 1 to n-1
            let w = if stack.is_empty() {
                n // Width is total length 'n'
            } else {
                n - stack.last().unwrap() - 1
            };
            max_area = max_area.max(h * w as i32);
        }

        max_area
    }
}