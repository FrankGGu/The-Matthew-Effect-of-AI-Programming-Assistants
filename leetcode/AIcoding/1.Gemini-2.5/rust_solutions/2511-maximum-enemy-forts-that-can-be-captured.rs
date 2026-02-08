impl Solution {
    pub fn max_captured_coins(forts: Vec<i32>) -> i32 {
        let n = forts.len();
        let mut max_captured = 0;
        let mut start_idx = -1; // Stores the index of the last encountered '1' or '0'
        let mut current_enemy_count = 0;

        for i in 0..n {
            if forts[i] != -1 { // Found a '1' or '0'
                if start_idx != -1 { // If we have a previous '1' or '0'
                    // Check if the current fort (forts[i]) and the fort at start_idx
                    // are different types (i.e., one is 1 and the other is 0).
                    // If they are, it means we have a valid segment for potential capture.
                    if forts[start_idx as usize] != forts[i] {
                        max_captured = max_captured.max(current_enemy_count);
                    }
                }
                // Update start_idx to the current position and reset enemy count.
                // This fort (forts[i]) now becomes the new potential start of a segment.
                start_idx = i as i32;
                current_enemy_count = 0;
            } else { // Found a '-1' (enemy fort)
                // If we have a valid starting fort ('1' or '0'), increment the enemy count.
                // Otherwise, if start_idx is -1, these enemy forts are not part of any capturable segment yet.
                if start_idx != -1 {
                    current_enemy_count += 1;
                }
            }
        }

        max_captured
    }
}