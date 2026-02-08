impl Solution {
    pub fn pass_the_pillow(n: i32, time: i32) -> i32 {
        let cycle = 2 * (n - 1);
        let remainder = time % cycle;
        if remainder < n {
            1 + remainder
        } else {
            n - (remainder - n + 1)
        }
    }
}