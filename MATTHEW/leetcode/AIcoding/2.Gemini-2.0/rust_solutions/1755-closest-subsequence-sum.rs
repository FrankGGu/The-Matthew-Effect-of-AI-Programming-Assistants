impl Solution {
    pub fn min_abs_difference(nums: Vec<i32>, goal: i32) -> i32 {
        fn get_sums(nums: &[i32]) -> Vec<i32> {
            let n = nums.len();
            let mut sums = vec![0];
            for &num in nums {
                let len = sums.len();
                for i in 0..len {
                    sums.push(sums[i] + num);
                }
            }
            sums.sort();
            sums.dedup();
            sums
        }

        let n = nums.len();
        let left_sums = get_sums(&nums[0..n / 2]);
        let right_sums = get_sums(&nums[n / 2..n]);

        let mut min_diff = i32::MAX;
        for &left_sum in &left_sums {
            let target = goal - left_sum;
            let mut low = 0;
            let mut high = right_sums.len() - 1;
            while low <= high {
                let mid = low + (high - low) / 2;
                let right_sum = right_sums[mid];
                let diff = (left_sum + right_sum - goal).abs();
                min_diff = min_diff.min(diff);
                if right_sum < target {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
        }

        min_diff
    }
}