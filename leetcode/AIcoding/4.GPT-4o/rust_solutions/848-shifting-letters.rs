pub fn shifting_letters(s: String, shifts: Vec<i32>) -> String {
    let n = s.len();
    let mut result = s.into_bytes();
    let mut total_shift = 0;

    for i in (0..n).rev() {
        total_shift = (total_shift + shifts[i]) % 26;
        result[i] = ((result[i] - b'a' + total_shift as u8) % 26 + b'a') as u8);
    }

    String::from_utf8(result).unwrap()
}