impl Solution {
    pub fn sub_str_hash(s: String, power: i32, modulo: i32, k: i32, hash_value: i32) -> String {
        let s = s.as_bytes();
        let n = s.len();
        let k = k as usize;
        let power = power as i64;
        let modulo = modulo as i64;
        let hash_value = hash_value as i64;

        let mut hash = 0i64;
        let mut power_k = 1i64;

        for i in (0..k).rev() {
            power_k = (power_k * power) % modulo;
            hash = (hash * power + (s[i] - b'a' + 1) as i64) % modulo;
        }

        let mut res = if hash == hash_value { 0 } else { n };

        for i in k..n {
            let outgoing = (s[i - k] - b'a' + 1) as i64;
            let incoming = (s[i] - b'a' + 1) as i64;
            hash = (hash * power - outgoing * power_k % modulo + incoming) % modulo;
            if hash < 0 {
                hash += modulo;
            }
            if hash == hash_value {
                res = i - k + 1;
            }
        }

        String::from_utf8(s[res..res + k].to_vec()).unwrap()
    }
}