impl Solution {
    pub fn get_smallest_string(n: i32, k: i32) -> String {
        let mut result_chars: Vec<char> = Vec::with_capacity(n as usize);
        let mut current_n = n;
        let mut current_k = k;

        for _ in 0..n {
            if current_k - 1 <= (current_n - 1) * 26 {
                result_chars.push('a');
                current_k -= 1;
            } else {
                let val = current_k - (current_n - 1);
                let char_code = (val - 1) as u8 + b'a';
                result_chars.push(char_code as char);
                current_k -= val;
            }
            current_n -= 1;
        }

        result_chars.into_iter().collect()
    }
}