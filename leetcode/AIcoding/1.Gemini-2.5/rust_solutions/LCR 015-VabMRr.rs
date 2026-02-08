impl Solution {
    pub fn find_anagrams(s: String, p: String) -> Vec<i32> {
        let s_len = s.len();
        let p_len = p.len();

        if s_len < p_len {
            return Vec::new();
        }

        let mut result: Vec<i32> = Vec::new();
        let s_bytes = s.as_bytes();
        let p_bytes = p.as_bytes();

        let mut p_counts = [0; 26];
        let mut window_counts = [0; 26];

        // Initialize p_counts
        for &byte in p_bytes.iter() {
            p_counts[(byte - b'a') as usize] += 1;
        }

        // Initialize the first window_counts
        for i in 0..p_len {
            window_counts[(s_bytes[i] - b'a') as usize] += 1;
        }

        // Check the first window
        if p_counts == window_counts {
            result.push(0);
        }

        // Slide the window
        for i in p_len..s_len {
            // Remove the character leaving the window
            window_counts[(s_bytes[i - p_len] - b'a') as usize] -= 1;
            // Add the character entering the window
            window_counts[(s_bytes[i] - b'a') as usize] += 1;

            // Check if the current window is an anagram
            if p_counts == window_counts {
                result.push((i - p_len + 1) as i32);
            }
        }

        result
    }
}