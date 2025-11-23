struct Solution;

impl Solution {
    pub fn maximal_rectangle(matrix: Vec<Vec<char>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let mut heights = vec![0; matrix[0].len()];
        let mut max_area = 0;

        for row in matrix {
            for i in 0..row.len() {
                if row[i] == '1' {
                    heights[i] += 1;
                } else {
                    heights[i] = 0;
                }
            }
            max_area = std::cmp::max(max_area, Solution::largest_rectangle_area(heights.clone()));
        }

        max_area
    }

    fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
        let mut max_area = 0;
        let mut stack = vec![];
        let mut heights = heights;
        heights.push(0);

        for i in 0..heights.len() {
            while !stack.is_empty() && heights[*stack.last().unwrap()] > heights[i] {
                let h = heights[stack.pop().unwrap()];
                let w = if stack.is_empty() { i } else { i - stack.last().unwrap() - 1 };
                max_area = std::cmp::max(max_area, h * w);
            }
            stack.push(i);
        }

        max_area
    }
}