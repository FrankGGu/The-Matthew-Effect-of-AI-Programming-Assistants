impl Solution {
    pub fn trap(height: Vec<i32>) -> i32 {
        if height.is_empty() {
            return 0;
        }

        let n = height.len();
        let mut left = 0;
        let mut right = n - 1;
        let mut max_left = 0;
        let mut max_right = 0;
        let mut trapped_water = 0;

        while left < right {
            if height[left] < height[right] {
                if height[left] >= max_left {
                    max_left = height[left];
                } else {
                    trapped_water += max_left - height[left];
                }
                left += 1;
            } else {
                if height[right] >= max_right {
                    max_right = height[right];
                } else {
                    trapped_water += max_right - height[right];
                }
                right -= 1;
            }
        }

        trapped_water
    }
}