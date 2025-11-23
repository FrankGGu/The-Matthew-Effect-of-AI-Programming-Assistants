impl Solution {
    pub fn sort_colors(nums: &mut Vec<i32>) {
        let mut low = 0;
        let mut mid = 0;
        let mut high = nums.len() as i32 - 1;

        while mid <= high {
            match nums[mid as usize] {
                0 => {
                    nums.swap(low as usize, mid as usize);
                    low += 1;
                    mid += 1;
                }
                1 => {
                    mid += 1;
                }
                2 => {
                    nums.swap(mid as usize, high as usize);
                    high -= 1;
                }
                _ => {
                    // This case should not be reached based on problem description (only 0, 1, 2)
                }
            }
        }
    }
}