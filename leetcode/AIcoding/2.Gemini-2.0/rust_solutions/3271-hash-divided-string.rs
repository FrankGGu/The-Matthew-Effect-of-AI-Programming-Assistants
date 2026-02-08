impl Solution {
    pub fn hash_divided_string(s: String, k: i32) -> i32 {
        let n = s.len();
        let k = k as usize;
        let mut count = 0;
        for i in 0..(n - k + 1) {
            let sub = &s[i..(i + k)];
            let mut hash_val: i64 = 0;
            for &c in sub.as_bytes() {
                hash_val = (hash_val * 31 + (c - b'a' + 1) as i64) % 1000000007;
            }

            if hash_val % 2 == 0 {
                count += 1;
            }
        }
        count
    }
}