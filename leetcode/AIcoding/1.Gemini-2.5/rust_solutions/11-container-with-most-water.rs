impl Solution {
    pub fn max_area(height: Vec<i32>) -> i32 {
        let mut max_area = 0;
        let mut left = 0;
        let mut right = height.len() - 1;

        while left < right {
            let h_left = height[left];
            let h_right = height[right];

            let current_height = h_left.min(h_right);
            let current_width = (right - left) as i32;
            let current_area = current_height * current_width;

            max_area = max_area.max(current_area);

            if h_left < h_right {
                left += 1;
            } else {
                right -= 1;
            }
        }

        max_area
    }
}