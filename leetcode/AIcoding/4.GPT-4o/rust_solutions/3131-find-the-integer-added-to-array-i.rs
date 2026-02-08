impl Solution {
    pub fn find_integer(nums: Vec<i32>, target: i32) -> i32 {
        let n = nums.len();
        let mut total = 0;
        for &num in &nums {
            total += num;
        }

        let mut left = 0;
        let mut right = target;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut sum = 0;
            for &num in &nums {
                if num <= mid {
                    sum += num;
                } else {
                    sum += mid;
                }
            }
            if sum < total {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        left
    }
}