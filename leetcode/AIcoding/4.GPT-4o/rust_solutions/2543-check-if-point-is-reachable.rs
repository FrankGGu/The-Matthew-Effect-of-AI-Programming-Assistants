pub fn is_reachable(x: i32, y: i32) -> bool {
    let mut x = x;
    let mut y = y;

    while x > 0 && y > 0 {
        if x > y {
            x %= y;
        } else {
            y %= x;
        }
    }

    x == 1 || y == 1 || (x == 0 && y == 0)
}