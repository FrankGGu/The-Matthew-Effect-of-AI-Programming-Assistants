impl Solution {
    pub fn find_the_child(n: i32, k: i32, start: i32) -> i32 {
        ((start + k) % n)
    }
}