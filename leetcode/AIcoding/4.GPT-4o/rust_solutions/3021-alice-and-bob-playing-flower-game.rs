pub fn flower_game(a: i32, b: i32) -> String {
    if a > b {
        return "Alice".to_string();
    } else if b > a {
        return "Bob".to_string();
    } else {
        return "Draw".to_string();
    }
}