impl Solution {
    pub fn split_array(nums: Vec<i32>, k: i32) -> i32 {
        let mut low = 0;
        let mut high = 0;

        for &num in nums.iter() {
            low = low.max(num);
            high += num;
        }

        while low < high {
            let mid = low + (high - low) / 2;
            if Self::can_split(&nums, k, mid) {
                high = mid;
            } else {
                low = mid + 1;
            }
        }
        low
    }

    fn can_split(nums: &Vec<i32>, k: i32, max_sum_limit: i32) -> bool {
        let mut current_sum = 0;
        let mut num_subarrays = 1;

        for &num in nums.iter() {
            if current_sum + num <= max_sum_limit {
                current_sum += num;
            } else {
                num_subarrays += 1;
                current_sum = num;
                if num_subarrays > k {
                    return false;
                }
            }
        }
        true
    }
}