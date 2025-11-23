impl Solution {
    pub fn find_lu_slength(a: String, b: String) -> i32 {
        if a != b {
            std::cmp::max(a.len() as i32, b.len() as i32)
        } else {
            -1
        }
    }
}