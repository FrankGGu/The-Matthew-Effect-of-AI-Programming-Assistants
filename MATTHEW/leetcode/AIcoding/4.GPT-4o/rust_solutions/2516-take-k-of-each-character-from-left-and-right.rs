pub fn take_characters(s: String, k: i32) -> i32 {
    use std::collections::HashMap;

    let n = s.len();
    let mut count = HashMap::new();
    let mut left = 0;
    let mut right = 0;
    let k = k as usize;

    while right < n {
        *count.entry(s.chars().nth(right).unwrap()).or_insert(0) += 1;
        while count.values().all(|&v| v >= k) {
            *count.entry(s.chars().nth(left).unwrap()).or_insert(0) -= 1;
            left += 1;
        }
        right += 1;
    }

    (n - left) as i32
}