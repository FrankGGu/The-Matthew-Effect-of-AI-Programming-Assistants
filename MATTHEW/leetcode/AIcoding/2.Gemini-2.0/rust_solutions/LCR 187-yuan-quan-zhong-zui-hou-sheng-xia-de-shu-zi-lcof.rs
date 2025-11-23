impl Solution {
    pub fn ice_breaking_game(num: i32) -> i32 {
        if num % 2 == 0 {
            2
        } else {
            1
        }
    }
}