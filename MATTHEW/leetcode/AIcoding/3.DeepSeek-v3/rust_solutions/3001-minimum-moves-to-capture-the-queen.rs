impl Solution {
    pub fn min_moves_to_capture_the_queen(a: i32, b: i32, c: i32, d: i32, e: i32, f: i32) -> i32 {
        if a == e && (c != e || (d < b.min(f) || d > b.max(f))) {
            return 1;
        }
        if b == f && (d != f || (c < a.min(e) || c > a.max(e))) {
            return 1;
        }
        if (c + d == e + f) && (a + b != e + f || (a < c.min(e) || a > c.max(e))) {
            return 1;
        }
        if (c - d == e - f) && (a - b != e - f || (a < c.min(e) || a > c.max(e))) {
            return 1;
        }
        2
    }
}