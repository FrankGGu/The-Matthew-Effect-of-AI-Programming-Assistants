impl Solution {
    pub fn get_smallest_string(n: i32, k: i32) -> String {
        let mut result = vec!['a'; n as usize];
        let mut remaining = k - n;

        for i in (0..n as usize).rev() {
            let add = std::cmp::min(25, remaining);
            result[i] = char::from_u32('a' as u32 + add as u32).unwrap();
            remaining -= add;
        }

        result.iter().collect()
    }
}