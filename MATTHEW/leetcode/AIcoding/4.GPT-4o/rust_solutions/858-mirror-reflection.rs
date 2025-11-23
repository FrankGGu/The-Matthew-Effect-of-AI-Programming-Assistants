impl Solution {
    pub fn mirror_reflection(p: i32, q: i32) -> i32 {
        if (p % 2 == 0) && (q % 2 == 0) {
            0
        } else if (p % 2 == 0) {
            2
        } else if (q % 2 == 0) {
            1
        } else {
            1
        }
    }
}