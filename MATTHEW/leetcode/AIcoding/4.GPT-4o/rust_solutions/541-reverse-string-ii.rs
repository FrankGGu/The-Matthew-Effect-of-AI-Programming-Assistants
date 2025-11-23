pub fn reverse_str(s: String, k: i32) -> String {
    let mut chars: Vec<char> = s.chars().collect();
    let n = chars.len();
    let k = k as usize;

    for i in (0..n).step_by(2 * k) {
        let end = std::cmp::min(i + k, n);
        chars[i..end].reverse();
    }

    chars.iter().collect()
}