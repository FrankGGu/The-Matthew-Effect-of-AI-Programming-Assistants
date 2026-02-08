impl Solution {
    pub fn min_cost(nums: Vec<i32>, cost: Vec<i32>, x: i32) -> i64 {
        let n = nums.len();
        let mut left = 0;
        let mut right = 10_000_000;

        while left < right {
            let mid = left + (right - left) / 2;
            let mut total_cost = 0;
            for i in 0..n {
                total_cost += (nums[i] - mid).abs() as i64 * cost[i] as i64;
            }
            if total_cost > x as i64 {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        let mut ans = i64::MAX;
        for target in left - 1..=left {
            let mut total_cost = 0;
            for i in 0..n {
                total_cost += (nums[i] - target).abs() as i64 * cost[i] as i64;
            }
            ans = ans.min(total_cost);
        }

        ans
    }
}