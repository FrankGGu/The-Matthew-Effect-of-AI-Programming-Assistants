impl Solution {
    pub fn minimum_limit(nums: Vec<i32>, max_operations: i32) -> i32 {
        let mut low = 1;
        let mut high = *nums.iter().max().unwrap();
        let mut ans = high;

        while low <= high {
            let mid = low + (high - low) / 2;

            let mut operations_needed: i64 = 0;
            for &num in nums.iter() {
                operations_needed += ((num - 1) / mid) as i64;
            }

            if operations_needed <= max_operations as i64 {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        ans
    }
}