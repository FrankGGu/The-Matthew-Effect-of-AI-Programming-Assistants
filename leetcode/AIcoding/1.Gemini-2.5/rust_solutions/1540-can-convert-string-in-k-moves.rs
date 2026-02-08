impl Solution {
    pub fn can_convert_string(s: String, t: String, k: i32) -> bool {
        if s.len() != t.len() {
            return false;
        }

        let n = s.len();
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();

        let mut counts = vec![0; 26]; // counts[d] stores how many times a shift of 'd' is needed

        for i in 0..n {
            let s_val = s_chars[i] as i32 - 'a' as i32;
            let t_val = t_chars[i] as i32 - 'a' as i32;

            let diff = (t_val - s_val + 26) % 26;

            if diff == 0 {
                // If characters are already the same, no positive 'x' move is needed.
                // The problem states 'x' must be a positive integer.
                continue;
            }

            counts[diff as usize] += 1;
        }

        let k_long = k as i64;

        // Check if the required moves for any shift 'd' exceed k
        for d in 1..26 { // Iterate for possible shifts from 1 to 25
            if counts[d] > 0 {
                // For the 'j'-th time we need a shift of 'd', the cost is d + (j-1)*26.
                // counts[d] represents the total number of times we need a shift of 'd'.
                // So, the maximum cost for this specific 'd' will be when we apply it for the counts[d]-th time.
                let required_moves = d as i64 + (counts[d] - 1) as i64 * 26;
                if required_moves > k_long {
                    return false;
                }
            }
        }

        true
    }
}