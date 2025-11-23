pub fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
    let mut max_area = 0;
    let mut stack = vec![];
    let mut heights = heights;
    heights.push(0); // Add a sentinel

    for i in 0..heights.len() {
        while let Some(&last) = stack.last() {
            if heights[last] <= heights[i] {
                break;
            }
            let height = heights[stack.pop().unwrap()];
            let width = if stack.is_empty() { i } else { i - stack.last().unwrap() - 1 };
            max_area = max_area.max(height * width);
        }
        stack.push(i);
    }
    max_area
}