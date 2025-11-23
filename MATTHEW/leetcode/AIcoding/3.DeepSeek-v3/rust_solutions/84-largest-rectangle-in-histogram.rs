impl Solution {
    pub fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
        let mut stack = Vec::new();
        let mut max_area = 0;
        let mut i = 0;
        let n = heights.len();

        while i <= n {
            let current_height = if i < n { heights[i] } else { 0 };
            while let Some(&top) = stack.last() {
                if current_height < heights[top] {
                    let height = heights[stack.pop().unwrap()];
                    let width = if stack.is_empty() { i } else { i - stack.last().unwrap() - 1 };
                    max_area = max_area.max(height * width as i32);
                } else {
                    break;
                }
            }
            stack.push(i);
            i += 1;
        }

        max_area
    }
}