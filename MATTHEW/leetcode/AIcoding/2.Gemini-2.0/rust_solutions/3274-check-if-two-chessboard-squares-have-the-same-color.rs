impl Solution {
    pub fn square_is_white(coordinates: String) -> bool {
        let c = coordinates.as_bytes();
        let col = (c[0] - b'a') as i32;
        let row = (c[1] - b'1') as i32;
        (col + row) % 2 != 0
    }
}