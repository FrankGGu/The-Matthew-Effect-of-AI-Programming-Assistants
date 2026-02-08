impl Solution {
    pub fn remove_duplicates(nums: &mut Vec<i32>) -> i32 {
        if nums.is_empty() {
            return 0;
        }
        let mut count = 1;
        for i in 1..nums.len() {
            if nums[i] != nums[i - 1] {
                nums[count] = nums[i];
                count += 1;
            }
        }
        nums.truncate(count);
        count as i32
    }
}