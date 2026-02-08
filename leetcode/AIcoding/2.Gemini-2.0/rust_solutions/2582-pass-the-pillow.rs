impl Solution {
    pub fn pass_the_pillow(n: i32, time: i32) -> i32 {
        let cycle = (time / (n - 1)) % 2;
        let rem = time % (n - 1);

        if cycle == 0 {
            rem + 1
        } else {
            n - rem
        }
    }
}