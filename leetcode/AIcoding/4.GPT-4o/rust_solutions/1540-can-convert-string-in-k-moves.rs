impl Solution {
    pub fn can_convert_string(s: String, t: String, k: i32) -> bool {
        if s.len() != t.len() {
            return false;
        }
        let mut shifts = [0; 26];
        let n = s.len();

        for i in 0..n {
            let diff = (t.chars().nth(i).unwrap() as i32 - s.chars().nth(i).unwrap() as i32 + 26) % 26;
            if diff != 0 {
                shifts[diff as usize] += 1;
            }
        }

        let total_moves: i32 = shifts.iter().enumerate().map(|(i, &count)| {
            if count > 0 {
                (i as i32 + 26 * (count - 1)) // the last occurrence needs to account for full rotations
            } else {
                0
            }
        }).sum();

        total_moves <= k
    }
}