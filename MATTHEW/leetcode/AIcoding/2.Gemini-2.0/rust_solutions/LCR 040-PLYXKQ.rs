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
            max_area = max_area.max(largest_rectangle_area(heights.clone()));
        }

        max_area
    }
}

fn largest_rectangle_area(heights: Vec<i32>) -> i32 {
    let mut stack: Vec<usize> = Vec::new();
    let mut max_area = 0;
    let n = heights.len();

    for i in 0..=n {
        while !stack.is_empty() && (i == n || heights[*stack.last().unwrap()] > heights.get(i).copied().unwrap_or(0)) {
            let height = heights[stack.pop().unwrap()];
            let width = match stack.last() {
                Some(&last) => i - last - 1,
                None => i,
            };
            max_area = max_area.max(height * width as i32);
        }
        stack.push(i);
    }

    max_area
}