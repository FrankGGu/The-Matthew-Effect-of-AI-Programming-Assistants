pub fn pass_the_pillow(n: i32, time: i32) -> i32 {
    let mut position = time % (2 * n - 2);
    if position < n {
        position + 1
    } else {
        2 * n - position - 1
    }
}