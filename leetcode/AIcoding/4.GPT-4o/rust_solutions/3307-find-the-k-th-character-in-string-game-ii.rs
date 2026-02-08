pub fn find_kth_character(s: String, n: i32, k: i32) -> char {
    let mut len = 1;
    let mut total_length = 0;
    let mut k = k - 1;

    while total_length + len < n as usize {
        total_length += len;
        len *= 2;
    }

    let mut pos = k - total_length;
    let mut length = len / 2;

    while length > 0 {
        if pos >= length {
            pos -= length;
            if pos == 0 {
                return s.chars().nth((k - 1) as usize % s.len()).unwrap();
            }
        }
        length /= 2;
    }

    s.chars().nth((k - 1) as usize % s.len()).unwrap()
}