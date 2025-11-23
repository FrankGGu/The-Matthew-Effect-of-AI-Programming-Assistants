impl Solution {
    pub fn find_lu_s_length(a: String, b: String) -> i32 {
        if a == b {
            -1
        } else {
            std::cmp::max(a.len(), b.len()) as i32
        }
    }
}