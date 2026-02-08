impl Solution {
    pub fn sort_colors(nums: &mut Vec<i32>) {
        let (mut low, mut mid, mut high) = (0, 0, nums.len() as i32 - 1);

        while mid <= high {
            match nums[mid as usize] {
                0 => {
                    nums.swap(low as usize, mid as usize);
                    low += 1;
                    mid += 1;
                }
                1 => mid += 1,
                2 => {
                    nums.swap(mid as usize, high as usize);
                    high -= 1;
                }
                _ => {}
            }
        }
    }
}