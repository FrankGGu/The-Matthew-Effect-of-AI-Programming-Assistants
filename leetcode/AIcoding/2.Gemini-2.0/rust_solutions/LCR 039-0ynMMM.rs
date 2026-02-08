impl Solution {
    pub fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
        let mut stack: Vec<usize> = Vec::new();
        let mut max_area = 0;
        let n = heights.len();

        for i in 0..=n {
            while !stack.is_empty() && (i == n || heights[*stack.last().unwrap()] > (if i == n { 0 } else { heights[i] })) {
                let top = stack.pop().unwrap();
                let area = heights[top] * (if stack.is_empty() { i as i32 } else { (i - *stack.last().unwrap() - 1) as i32 });
                max_area = max_area.max(area);
            }
            stack.push(i);
        }

        max_area
    }
}