struct Solution {}

impl Solution {
    pub fn square_is_white(coordinates: String) -> bool {
        let chars: Vec<char> = coordinates.chars().collect();
        let col = chars[0] as u8 - b'a';
        let row = chars[1] as u8 - b'1';
        (col + row) % 2 == 1
    }
}