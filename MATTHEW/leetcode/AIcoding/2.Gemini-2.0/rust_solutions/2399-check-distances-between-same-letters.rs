impl Solution {
    pub fn check_distances(s: String, distance: Vec<i32>) -> bool {
        let mut first_occurrence = std::collections::HashMap::new();
        let chars: Vec<char> = s.chars().collect();

        for (i, &c) in chars.iter().enumerate() {
            if !first_occurrence.contains_key(&c) {
                first_occurrence.insert(c, i as i32);
            }
        }

        for (i, &c) in chars.iter().enumerate() {
            let char_index = (c as u8 - b'a') as usize;
            if first_occurrence.get(&c).map_or(false, |&first| {
                (i as i32) - first - 1 != distance[char_index]
            }) {
                return false;
            }
            first_occurrence.remove(&c);
        }

        true
    }
}