impl Solution {
    pub fn square_is_white(coordinates: String) -> bool {
        let bytes = coordinates.as_bytes();
        let x = bytes[0] - b'a';
        let y = bytes[1] - b'1';
        (x + y) % 2 != 0
    }
}