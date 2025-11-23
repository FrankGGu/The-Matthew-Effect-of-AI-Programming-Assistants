impl Solution {
    pub fn maximal_rectangle(matrix: Vec<Vec<char>>) -> i32 {
        if matrix.is_empty() {
            return 0;
        }
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut heights = vec![0; cols];
        let mut max_area = 0;

        for i in 0..rows {
            for j in 0..cols {
                if matrix[i][j] == '1' {
                    heights[j] += 1;
                } else {
                    heights[j] = 0;
                }
            }
            max_area = max_area.max(Self::largest_rectangle_area(heights.clone()));
        }

        max_area
    }

    fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
        let mut stack: Vec<usize> = Vec::new();
        let mut max_area = 0;
        let mut i = 0;
        let n = heights.len();

        while i <= n {
            let h = if i == n { 0 } else { heights[i] };
            if stack.is_empty() || h >= heights[*stack.last().unwrap()] {
                stack.push(i);
                i += 1;
            } else {
                let top = stack.pop().unwrap();
                let area = heights[top] * if stack.is_empty() {
                    i as i32
                } else {
                    (i - *stack.last().unwrap() - 1) as i32
                };
                max_area = max_area.max(area);
            }
        }

        max_area
    }
}