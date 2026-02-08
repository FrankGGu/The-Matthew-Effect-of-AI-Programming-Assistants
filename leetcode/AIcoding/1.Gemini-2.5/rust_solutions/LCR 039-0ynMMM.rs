impl Solution {
    pub fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
        let n = heights.len();
        let mut max_area = 0;
        let mut stack: Vec<usize> = Vec::new(); // Stores indices of bars in increasing order of height

        for i in 0..=n {
            let h_i = if i == n { 0 } else { heights[i] };

            while let Some(&top_idx) = stack.last() {
                if h_i < heights[top_idx] {
                    stack.pop();
                    let h = heights[top_idx];
                    let w = if let Some(&prev_idx) = stack.last() {
                        (i - prev_idx - 1) as i32
                    } else {
                        i as i32
                    };
                    max_area = max_area.max(h * w);
                } else {
                    break;
                }
            }
            stack.push(i);
        }

        max_area
    }
}