impl Solution {
    pub fn separate_black_and_white_balls(balls: String) -> i32 {
        let balls_vec: Vec<char> = balls.chars().collect();
        let mut swaps = 0;
        let mut left = 0;

        for right in 0..balls_vec.len() {
            if balls_vec[right] == '1' {
                swaps += (right - left) as i32;
                left += 1;
            }
        }

        swaps
    }
}