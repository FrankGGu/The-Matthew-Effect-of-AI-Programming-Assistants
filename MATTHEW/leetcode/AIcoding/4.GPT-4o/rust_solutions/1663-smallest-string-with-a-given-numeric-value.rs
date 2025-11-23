impl Solution {
    pub fn get_smallest_string(n: i32, k: i32) -> String {
        let mut result = vec!['a'; n as usize];
        let mut total_value = k;

        for i in (0..n as usize).rev() {
            if total_value <= 0 {
                break;
            }
            let max_add = (total_value - 1).min(25);
            result[i] = (b'a' + max_add as u8) as char;
            total_value -= max_add + 1;
        }

        result.into_iter().collect()
    }
}