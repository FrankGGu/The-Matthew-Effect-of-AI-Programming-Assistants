impl Solution {
    pub fn min_cost(nums: Vec<i32>, cost: Vec<i32>, x: i32) -> i64 {
        let mut total_cost = 0i64;
        let mut total_elements = 0i64;
        let n = nums.len();
        let mut left = *nums.iter().min().unwrap();
        let mut right = *nums.iter().max().unwrap();

        while left < right {
            let mid = (left + right) / 2;
            let mut current_cost = 0i64;
            let mut current_elements = 0i64;

            for i in 0..n {
                if nums[i] < mid {
                    current_cost += (mid - nums[i]) as i64 * cost[i] as i64;
                    current_elements += cost[i] as i64;
                }
            }

            if current_cost > x * current_elements {
                right = mid;
            } else {
                current_cost = 0;
                current_elements = 0;

                for i in 0..n {
                    if nums[i] > mid {
                        current_cost += (nums[i] - mid) as i64 * cost[i] as i64;
                        current_elements += cost[i] as i64;
                    }
                }

                if current_cost > x * current_elements {
                    left = mid + 1;
                } else {
                    total_cost = current_cost;
                    left = mid + 1;
                }
            }
        }

        total_cost
    }
}