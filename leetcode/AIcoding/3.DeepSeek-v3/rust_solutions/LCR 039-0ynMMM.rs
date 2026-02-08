impl Solution {
    pub fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
        let mut stack = Vec::new();
        let mut max_area = 0;
        let n = heights.len();
        let mut left = vec![-1; n];
        let mut right = vec![n as i32; n];

        for i in 0..n {
            while !stack.is_empty() && heights[*stack.last().unwrap()] >= heights[i] {
                stack.pop();
            }
            if !stack.is_empty() {
                left[i] = *stack.last().unwrap() as i32;
            }
            stack.push(i);
        }

        stack.clear();

        for i in (0..n).rev() {
            while !stack.is_empty() && heights[*stack.last().unwrap()] >= heights[i] {
                stack.pop();
            }
            if !stack.is_empty() {
                right[i] = *stack.last().unwrap() as i32;
            }
            stack.push(i);
        }

        for i in 0..n {
            max_area = max_area.max(heights[i] * (right[i] - left[i] - 1));
        }

        max_area
    }
}