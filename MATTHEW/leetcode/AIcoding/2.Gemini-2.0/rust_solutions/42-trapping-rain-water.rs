impl Solution {
    pub fn trap(height: Vec<i32>) -> i32 {
        let n = height.len();
        if n == 0 {
            return 0;
        }

        let mut left_max = vec![0; n];
        let mut right_max = vec![0; n];

        left_max[0] = height[0];
        for i in 1..n {
            left_max[i] = std::cmp::max(left_max[i - 1], height[i]);
        }

        right_max[n - 1] = height[n - 1];
        for i in (0..n - 1).rev() {
            right_max[i] = std::cmp::max(right_max[i + 1], height[i]);
        }

        let mut trapped_water = 0;
        for i in 0..n {
            trapped_water += std::cmp::min(left_max[i], right_max[i]) - height[i];
        }

        trapped_water
    }
}