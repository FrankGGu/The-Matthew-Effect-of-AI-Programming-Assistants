struct Solution;

impl Solution {
    pub fn maximal_rectangle(matrix: Vec<Vec<char>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let m = matrix.len();
        let n = matrix[0].len();
        let mut max_area = 0;
        let mut heights = vec![0; n];

        for i in 0..m {
            for j in 0..n {
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
        let mut max_area = 0;
        let mut stack: Vec<usize> = Vec::new();

        let mut h_extended = heights.to_vec();
        h_extended.push(0); 

        for i in 0..h_extended.len() {
            while let Some(&top_idx) = stack.last() {
                if h_extended[top_idx] >= h_extended[i] {
                    stack.pop();
                    let h = h_extended[top_idx];
                    let w = if stack.is_empty() {
                        i as i32
                    } else {
                        (i - stack.last().unwrap() - 1) as i32
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