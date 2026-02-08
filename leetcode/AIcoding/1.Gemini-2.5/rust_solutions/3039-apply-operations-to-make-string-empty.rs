impl Solution {
    pub fn apply_operations_to_make_string_empty(s: String, k: i32) -> i32 {
        (s.len() % (k as usize)) as i32
    }
}