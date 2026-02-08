impl Solution {
    pub fn maximal_rectangle(matrix: Vec<Vec<char>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }
        let m = matrix.len();
        let n = matrix[0].len();
        let mut heights = vec![0; n];
        let mut max_area = 0;

        for i in 0..m {
            for j in 0..n {
                heights[j] = if matrix[i][j] == '1' { heights[j] + 1 } else { 0 };
            }
            max_area = max_area.max(Self::largest_rectangle_area(&heights));
        }

        max_area
    }

    fn largest_rectangle_area(heights: &[i32]) -> i32 {
        let mut stack = vec![];
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
                let width = if stack.is_empty() { i } else { i - stack.last().unwrap() - 1 };
                max_area = max_area.max(heights[top] * width as i32);
            }
        }

        max_area
    }
}