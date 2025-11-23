impl Solution {
    pub fn maximal_rectangle(matrix: Vec<Vec<char>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let m = matrix.len();
        let n = matrix[0].len();
        let mut heights = vec![0; n];
        let mut max_area = 0;

        for row in matrix {
            for j in 0..n {
                if row[j] == '1' {
                    heights[j] += 1;
                } else {
                    heights[j] = 0;
                }
            }
            max_area = max_area.max(Self::largest_rectangle_area(&heights));
        }

        max_area
    }

    fn largest_rectangle_area(heights: &Vec<i32>) -> i32 {
        let mut stack = vec![];
        let mut max_area = 0;
        let mut heights = heights.clone();
        heights.push(0);

        for (i, &h) in heights.iter().enumerate() {
            while let Some(&last) = stack.last() {
                if h < heights[last] {
                    let height = heights[stack.pop().unwrap()];
                    let width = if stack.is_empty() { i } else { i - stack.last().unwrap() - 1 };
                    max_area = max_area.max(height * width);
                } else {
                    break;
                }
            }
            stack.push(i);
        }

        max_area
    }
}