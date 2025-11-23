impl Solution {
    pub fn min_deletion(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut i = 0;
        while i < nums.len() - count - 1 {
            if (i % 2) == 0 && nums[i] == nums[i + 1] {
                count += 1;
            } else {
                i += 1;
            }
            i += 1;
        }

        if (nums.len() as i32 - count) % 2 != 0 {
            count += 1;
        }

        count
    }
}