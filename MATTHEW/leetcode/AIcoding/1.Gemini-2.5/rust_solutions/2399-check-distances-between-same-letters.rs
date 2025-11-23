impl Solution {
    pub fn check_distances(s: String, distances: Vec<i32>) -> bool {
        let mut first_occurrence: [i32; 26] = [-1; 26];

        for (i, c) in s.chars().enumerate() {
            let char_idx = (c as u8 - b'a') as usize;

            if first_occurrence[char_idx] == -1 {
                first_occurrence[char_idx] = i as i32;
            } else {
                let calculated_distance = i as i32 - first_occurrence[char_idx] - 1;
                if calculated_distance != distances[char_idx] {
                    return false;
                }
            }
        }

        true
    }
}