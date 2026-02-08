pub fn restore_string(s: String, indices: Vec<i32>) -> String {
    let mut result = vec![' '; s.len()];
    for (i, &index) in indices.iter().enumerate() {
        result[index as usize] = s.chars().nth(i).unwrap();
    }
    result.iter().collect()
}