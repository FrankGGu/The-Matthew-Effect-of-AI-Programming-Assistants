pub fn game(n: i32) -> i32 {
    if n % 2 == 0 {
        n / 2
    } else {
        (n + 1) / 2
    }
}