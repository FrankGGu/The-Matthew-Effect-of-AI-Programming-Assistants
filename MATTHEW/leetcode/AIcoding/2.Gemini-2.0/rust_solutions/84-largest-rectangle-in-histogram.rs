impl Solution {
    pub fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
        let mut stack: Vec<usize> = Vec::new();
        let mut max_area = 0;
        let n = heights.len();

        for i in 0..=n {
            let current_height = if i == n { 0 } else { heights[i] };

            while !stack.is_empty() && current_height < heights[*stack.last().unwrap()] {
                let top = stack.pop().unwrap();
                let height = heights[top];
                let width = if stack.is_empty() {
                    i
                } else {
                    i - *stack.last().unwrap() - 1
                };
                max_area = max_area.max(height * width as i32);
            }
            stack.push(i);
        }

        max_area
    }
}