impl Solution {
    pub fn minimum_array_length(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let min_val = nums[0];
        let mut count = 0;
        for &num in &nums {
            if num % min_val == 0 {
                count += 1;
            }
        }
        if count > (nums.len() + 1) / 2 {
            (nums.len() as i32 + 1) / 2
        } else {
            nums.len() as i32 - count as i32 + (count as i32)
        }

        let mut cnt = 0;
        for &num in &nums {
            if num % min_val == 0 {
                cnt +=1;
            }
        }

        if cnt > (nums.len() + 1) / 2 {
            (nums.len() as i32 + 1) / 2
        }else {
            (nums.len() as i32 - cnt as i32) + ((cnt as i32 + 1) / 2)
        }
    }
}