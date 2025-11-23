pub fn sub_str_hash(s: String, power: i32, modulo: i32, k: i32, hash_value: i32) -> String {
    let n = s.len();
    let mut p = 1;
    let mut current_hash = 0;

    for i in (0..k as usize).rev() {
        current_hash = (current_hash + (s.as_bytes()[i] - b'a' + 1) as i64 * p as i64) % modulo as i64;
        if i > 0 {
            p = (p * power as i64) % modulo as i64;
        }
    }

    if current_hash as i32 == hash_value {
        return s[..k as usize].to_string();
    }

    for i in k as usize..n {
        current_hash = (current_hash * power as i64 - (s.as_bytes()[i - k] - b'a' + 1) as i64 * p as i64 + (s.as_bytes()[i] - b'a' + 1) as i64) % modulo as i64;
        current_hash = (current_hash + modulo as i64) % modulo as i64;

        if current_hash as i32 == hash_value {
            return s[i - k + 1..=i].to_string();
        }
    }

    "".to_string()
}