impl Solution {
    fn calculate(x: i32, a: i32, b: i32, c: i32) -> i32 {
        a * x * x + b * x + c
    }

    pub fn sort_transformed_array(nums: Vec<i32>, a: i32, b: i32, c: i32) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];

        if n == 0 {
            return result;
        }

        let mut left = 0;
        let mut right = n - 1;

        if a >= 0 {
            // If 'a' is positive (parabola opens upwards) or zero with non-negative 'b' (non-decreasing line),
            // the largest values are at the ends of the 'nums' range.
            // We fill the result array from right to left (largest to smallest).
            let mut idx = n - 1;
            while left <= right {
                let val_left = Self::calculate(nums[left], a, b, c);
                let val_right = Self::calculate(nums[right], a, b, c);

                if val_left > val_right {
                    result[idx] = val_left;
                    left += 1;
                } else {
                    result[idx] = val_right;
                    right -= 1;
                }
                idx -= 1;
            }
        } else { // a < 0
            // If 'a' is negative (parabola opens downwards) or zero with negative 'b' (decreasing line),
            // the smallest values are at the ends of the 'nums' range.
            // We fill the result array from left to right (smallest to largest).
            let mut idx = 0;
            while left <= right {
                let val_left = Self::calculate(nums[left], a, b, c);
                let val_right = Self::calculate(nums[right], a, b, c);

                if val_left < val_right {
                    result[idx] = val_left;
                    left += 1;
                } else {
                    result[idx] = val_right;
                    right -= 1;
                }
                idx += 1;
            }
        }

        result
    }
}