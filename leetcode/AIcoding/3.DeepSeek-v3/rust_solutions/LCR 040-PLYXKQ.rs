impl Solution {
    pub fn maximal_rectangle(matrix: Vec<Vec<char>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut heights = vec![0; cols];
        let mut max_area = 0;

        for i in 0..rows {
            for j in 0..cols {
                heights[j] = if matrix[i][j] == '1' { heights[j] + 1 } else { 0 };
            }
            max_area = max_area.max(Self::largest_rectangle_area(&heights));
        }

        max_area
    }

    fn largest_rectangle_area(heights: &[i32]) -> i32 {
        let mut stack = vec![-1];
        let mut max_area = 0;
        for i in 0..heights.len() {
            while stack.len() > 1 && heights[i] < heights[*stack.last().unwrap() as usize] {
                let h = heights[stack.pop().unwrap() as usize];
                let w = i as i32 - stack.last().unwrap() - 1;
                max_area = max_area.max(h * w);
            }
            stack.push(i as i32);
        }
        while stack.len() > 1 {
            let h = heights[stack.pop().unwrap() as usize];
            let w = heights.len() as i32 - stack.last().unwrap() - 1;
            max_area = max_area.max(h * w);
        }
        max_area
    }
}