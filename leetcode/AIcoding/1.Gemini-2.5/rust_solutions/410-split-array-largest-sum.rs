impl Solution {
    pub fn split_array(nums: Vec<i32>, k: i32) -> i32 {
        let mut low = 0;
        let mut high = 0;

        for &num in nums.iter() {
            low = low.max(num);
            high += num;
        }

        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;
            if Self::can_split(&nums, k, mid) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        ans
    }

    fn can_split(nums: &Vec<i32>, k: i32, max_sum_limit: i32) -> bool {
        let mut num_subarrays = 1;
        let mut current_sum = 0;

        for &num in nums.iter() {
            if current_sum + num > max_sum_limit {
                num_subarrays += 1;
                current_sum = num;
                if num_subarrays > k {
                    return false;
                }
            } else {
                current_sum += num;
            }
        }
        true
    }
}