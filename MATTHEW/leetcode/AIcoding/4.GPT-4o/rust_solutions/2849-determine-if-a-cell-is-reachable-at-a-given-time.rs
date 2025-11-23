pub fn can_reach(x: i32, y: i32, time: i32) -> bool {
    let distance = x.abs() + y.abs();
    distance <= time && (time - distance) % 2 == 0
}