pub fn check_distances(s: String, distance: Vec<i32>) -> bool {
    let mut last_index = vec![-1; 26];

    for (i, c) in s.chars().enumerate() {
        let idx = (c as u8 - b'a') as usize;
        if last_index[idx] == -1 {
            last_index[idx] = i as i32;
        } else {
            if (i as i32 - last_index[idx]) != distance[idx] {
                return false;
            }
            last_index[idx] = i as i32;
        }
    }

    true
}