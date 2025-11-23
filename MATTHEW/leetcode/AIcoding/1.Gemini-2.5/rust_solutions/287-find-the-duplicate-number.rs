impl Solution {
    pub fn find_duplicate(nums: &Vec<i32>) -> i32 {
        let mut slow = nums[0];
        let mut fast = nums[nums[0] as usize];

        loop {
            slow = nums[slow as usize];
            fast = nums[nums[fast as usize] as usize];
            if slow == fast {
                break;
            }
        }

        let mut slow2 = 0;
        loop {
            slow2 = nums[slow2 as usize];
            slow = nums[slow as usize];
            if slow == slow2 {
                break;
            }
        }
        slow
    }
}