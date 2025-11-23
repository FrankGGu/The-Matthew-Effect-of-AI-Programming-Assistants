impl Solution {
    pub fn square_is_white(coordinates: String) -> bool {
        let bytes = coordinates.as_bytes();
        let col = (bytes[0] - b'a') as i32;
        let row = (bytes[1] - b'1') as i32;
        (col + row) % 2 == 1
    }
}