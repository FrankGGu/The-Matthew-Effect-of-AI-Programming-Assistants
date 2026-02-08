struct Solution;

impl Solution {
    pub fn smallest_distance_pair(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort_unstable();

        let n = nums.len();
        let mut low = 0;
        let mut high = nums[n - 1] - nums[0];
        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            let count = Self::count_pairs_le_distance(&nums, mid);

            if count >= k {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }

    fn count_pairs_le_distance(nums: &[i32], d: i32) -> i32 {
        let n = nums.len();
        let mut count = 0;
        let mut left = 0;
        for right in 0..n {
            while nums[right] - nums[left] > d {
                left += 1;
            }
            count += (right - left) as i32;
        }
        count
    }
}