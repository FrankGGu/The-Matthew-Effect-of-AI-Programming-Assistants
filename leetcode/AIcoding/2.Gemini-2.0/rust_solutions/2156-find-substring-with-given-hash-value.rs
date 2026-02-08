impl Solution {
    pub fn sub_str_hash(s: String, power: i32, modulo: i32, k: i32, hash_value: i32) -> String {
        let n = s.len();
        let k = k as usize;
        let power = power as i64;
        let modulo = modulo as i64;
        let hash_value = hash_value as i64;
        let s_bytes = s.as_bytes();

        let mut hash = 0;
        let mut p = 1;

        for i in (n - k..n).rev() {
            hash = (hash * power + (s_bytes[i] - b'a' + 1) as i64) % modulo;
            if i < n - 1 {
                p = (p * power) % modulo;
            }
        }

        if hash == hash_value {
            return s[n - k..].to_string();
        }

        for i in (0..n - k).rev() {
            hash = (hash - (s_bytes[i + k] - b'a' + 1) as i64 * p % modulo + modulo) % modulo;
            hash = (hash * power + (s_bytes[i] - b'a' + 1) as i64) % modulo;

            if hash == hash_value {
                return s[i..i + k].to_string();
            }
        }

        "".to_string()
    }
}