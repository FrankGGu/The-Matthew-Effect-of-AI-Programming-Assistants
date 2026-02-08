impl Solution {
    pub fn sort_colors(nums: &mut Vec<i32>) {
        let mut counts = [0, 0, 0];
        for &num in nums.iter() {
            counts[num as usize] += 1;
        }
        let mut i = 0;
        for color in 0..3 {
            for _ in 0..counts[color] {
                nums[i] = color as i32;
                i += 1;
            }
        }
    }
}