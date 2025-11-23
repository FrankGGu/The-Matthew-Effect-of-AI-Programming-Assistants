impl Solution {
    pub fn find_duplicate(nums: Vec<i32>) -> i32 {
        let mut slow = nums[0];
        let mut fast = nums[0];

        loop {
            slow = nums[slow as usize];
            fast = nums[nums[fast as usize] as usize];
            if slow == fast {
                break;
            }
        }

        let mut finder = nums[0];
        while finder != slow {
            finder = nums[finder as usize];
            slow = nums[slow as usize];
        }

        finder
    }
}