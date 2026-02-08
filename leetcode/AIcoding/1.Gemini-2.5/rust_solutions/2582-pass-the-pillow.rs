impl Solution {
    pub fn pass_the_pillow(n: i32, time: i32) -> i32 {
        let cycle_len = 2 * (n - 1);
        let time_in_cycle = time % cycle_len;

        if time_in_cycle < n - 1 {
            1 + time_in_cycle
        } else {
            n - (time_in_cycle - (n - 1))
        }
    }
}