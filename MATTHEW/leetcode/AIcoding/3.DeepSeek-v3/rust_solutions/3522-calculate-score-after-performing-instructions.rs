impl Solution {
    pub fn calculate_score(start_pos: i32, nums: Vec<i32>, s: String) -> i32 {
        let mut pos = start_pos;
        let mut score = 0;
        for c in s.chars() {
            match c {
                'L' => pos -= 1,
                'R' => pos += 1,
                _ => (),
            }
            if pos < 0 || pos >= nums.len() as i32 {
                return -1;
            }
            score += nums[pos as usize];
        }
        score
    }
}