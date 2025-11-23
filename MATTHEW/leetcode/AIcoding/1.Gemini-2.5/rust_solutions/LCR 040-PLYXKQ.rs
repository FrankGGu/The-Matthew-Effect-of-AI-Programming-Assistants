struct Solution;

impl Solution {
    pub fn maximal_rectangle(matrix: Vec<Vec<char>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut max_area = 0;
        let mut heights: Vec<i32> = vec![0; cols];

        for i in 0..rows {
            for j in 0..cols {
                if matrix[i][j] == '1' {
                    heights[j] += 1;
                } else {
                    heights[j] = 0;
                }
            }
            max_area = max_area.max(Self::largest_rectangle_in_histogram(&heights));
        }

        max_area
    }

    fn largest_rectangle_in_histogram(heights: &[i32]) -> i32 {
        let mut max_hist_area = 0;
        let mut stack: Vec<usize> = Vec::new(); // Stores indices

        for k in 0..=heights.len() {
            let h = if k == heights.len() { 0 } else { heights[k] };

            while !stack.is_empty() && heights[*stack.last().unwrap()] >= h {
                let top_idx = stack.pop().unwrap();
                let top_height = heights[top_idx];
                let width = if stack.is_empty() {
                    k as i32
                } else {
                    (k - stack.last().unwrap() - 1) as i32
                };
                max_hist_area = max_hist_area.max(top_height * width);
            }
            stack.push(k);
        }
        max_hist_area
    }
}