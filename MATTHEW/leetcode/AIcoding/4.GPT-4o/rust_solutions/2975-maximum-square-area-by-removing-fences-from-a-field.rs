impl Solution {
    pub fn max_square_area(heights: Vec<i32>) -> i32 {
        let n = heights.len();
        let mut max_side = 0;
        let mut left = vec![0; n];
        let mut right = vec![n; n];
        let mut height = vec![0; n];

        for i in 1..n {
            left[i] = if heights[i] > heights[i - 1] { left[i - 1] } else { i };
        }
        for i in (0..n - 1).rev() {
            right[i] = if heights[i] > heights[i + 1] { right[i + 1] } else { i + 1 };
        }
        for i in 0..n {
            height[i] = right[i] - left[i];
            max_side = max_side.max(height[i].min(heights[i]));
        }

        max_side * max_side
    }
}