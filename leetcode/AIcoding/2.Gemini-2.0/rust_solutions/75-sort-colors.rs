impl Solution {
    pub fn sort_colors(nums: &mut Vec<i32>) {
        let mut red = 0;
        let mut white = 0;
        let mut blue = nums.len();

        while white < blue {
            match nums[white] {
                0 => {
                    nums.swap(red, white);
                    red += 1;
                    white += 1;
                }
                1 => {
                    white += 1;
                }
                2 => {
                    blue -= 1;
                    nums.swap(white, blue);
                }
                _ => {}
            }
        }
    }
}