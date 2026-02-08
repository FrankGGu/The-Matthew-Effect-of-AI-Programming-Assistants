pub fn decode_at_index(s: String, k: i32) -> String {
    let mut length = 0;
    let k = k as usize;

    for c in s.chars() {
        if c.is_digit(10) {
            length *= c.to_digit(10).unwrap() as usize;
        } else {
            length += 1;
        }
    }

    for c in s.chars().rev() {
        if c.is_digit(10) {
            length /= c.to_digit(10).unwrap() as usize;
            k %= length;
        } else {
            if k == 0 || k == length {
                return c.to_string();
            }
            length -= 1;
        }
    }

    String::new()
}