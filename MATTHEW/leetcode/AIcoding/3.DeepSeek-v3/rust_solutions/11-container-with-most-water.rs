impl Solution {
    pub fn max_area(height: Vec<i32>) -> i32 {
        let mut max_area = 0;
        let mut left = 0;
        let mut right = height.len() - 1;

        while left < right {
            let current_height = std::cmp::min(height[left], height[right]);
            let current_width = (right - left) as i32;
            let current_area = current_height * current_width;
            max_area = std::cmp::max(max_area, current_area);

            if height[left] < height[right] {
                left += 1;
            } else {
                right -= 1;
            }
        }

        max_area
    }
}