impl Solution {
    pub fn max_num_of_marked_indices(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut count = 0;

        for i in 0..n / 2 {
            if nums[i] * 2 <= nums[n - 1 - i] {
                count += 2;
            } else {
                break;
            }
        }

        if n % 2 == 1 {
            count += 1;
        }

        count
    }
}