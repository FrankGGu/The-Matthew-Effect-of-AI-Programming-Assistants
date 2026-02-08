pub fn categorize_box(length: i32, width: i32, height: i32, mass: i32) -> String {
    let volume = length as i64 * width as i64 * height as i64;
    let is_heavy = mass >= 100;
    let is_bulky = length >= 10000 || width >= 10000 || height >= 10000 || volume >= 1_000_000_000;

    if is_bulky {
        if is_heavy {
            return "Both".to_string();
        } else {
            return "Bulky".to_string();
        }
    } else {
        if is_heavy {
            return "Heavy".to_string();
        } else {
            return "Neither".to_string();
        }
    }
}