impl Solution {
    pub fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
        let mut stack = vec![];
        let mut max_area = 0;
        let mut heights = heights.clone();
        heights.push(0);

        for (i, &h) in heights.iter().enumerate() {
            while let Some(&top) = stack.last() {
                if h < heights[top] {
                    let height = heights[stack.pop().unwrap()];
                    let width = if stack.is_empty() { i } else { i - stack.last().unwrap() - 1 };
                    max_area = max_area.max(height * width as i32);
                } else {
                    break;
                }
            }
            stack.push(i);
        }

        max_area
    }
}