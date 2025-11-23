impl Solution {
    pub fn square_is_white(coordinates: String) -> bool {
        let bytes = coordinates.as_bytes();
        let row = bytes[0] as usize - 'a' as usize;
        let col = bytes[1] as usize - '1' as usize;
        (row + col) % 2 == 1
    }
}