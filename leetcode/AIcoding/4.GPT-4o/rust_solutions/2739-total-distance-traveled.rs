pub fn distance_traveled(main: i32, extra: i32) -> i32 {
    let full_tanks = main / 5;
    let distance = full_tanks * 50;
    let remaining = main % 5 + extra;

    if remaining >= 5 {
        distance + 50
    } else {
        distance
    }
}