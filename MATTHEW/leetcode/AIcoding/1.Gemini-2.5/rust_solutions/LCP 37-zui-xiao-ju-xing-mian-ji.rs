impl Solution {
    pub fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
        let mut heights = heights;
        heights.push(0); // Sentinel value to process all remaining bars in the stack
        let n = heights.len();
        let mut stack: Vec<usize> = Vec::new(); // Stores indices of bars
        let mut max_area = 0;

        for i in 0..n {
            // While the stack is not empty and the current bar is shorter than the bar at the top of the stack
            while !stack.is_empty() && heights[*stack.last().unwrap()] >= heights[i] {
                let h_idx = stack.pop().unwrap();
                let h = heights[h_idx];

                // Calculate the width of the rectangle with height `h`
                // If the stack is empty after popping, it means `h` is the smallest bar encountered so far
                // and it can extend from index 0 up to `i-1`. So, width = i.
                // Otherwise, the bar at `stack.last().unwrap()` is the first bar to the left that is shorter or equal.
                // So, the width extends from `stack.last().unwrap() + 1` up to `i-1`.
                // Width = (i - 1) - (stack.last().unwrap() + 1) + 1 = i - stack.last().unwrap() - 1.
                let width = if stack.is_empty() {
                    i as i32
                } else {
                    (i - stack.last().unwrap() - 1) as i32
                };

                max_area = max_area.max(h * width);
            }
            stack.push(i);
        }
        max_area
    }
}