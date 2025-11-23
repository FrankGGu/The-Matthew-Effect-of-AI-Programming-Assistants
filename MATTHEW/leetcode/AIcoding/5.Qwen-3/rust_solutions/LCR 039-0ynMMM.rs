struct Solution;

impl Solution {
    pub fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
        let mut max_area = 0;
        let mut stack = Vec::new();

        for (i, &h) in heights.iter().enumerate() {
            while let Some(&top_idx) = stack.last() {
                if heights[top_idx] <= h {
                    break;
                }
                let top = stack.pop().unwrap();
                let height = heights[top];
                let width = if let Some(&prev_idx) = stack.last() {
                    i - prev_idx - 1
                } else {
                    i
                };
                max_area = std::cmp::max(max_area, height * width as i32);
            }
            stack.push(i);
        }

        let n = heights.len();
        while let Some(top) = stack.pop() {
            let height = heights[top];
            let width = if let Some(&prev_idx) = stack.last() {
                n - prev_idx - 1
            } else {
                n
            };
            max_area = std::cmp::max(max_area, height * width as i32);
        }

        max_area
    }
}