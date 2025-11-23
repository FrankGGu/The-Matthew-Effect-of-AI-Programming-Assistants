impl Solution {
    pub fn square_is_white(coordinates: String) -> bool {
        let col_char = coordinates.chars().next().unwrap();
        let row_char = coordinates.chars().nth(1).unwrap();

        let col_val = (col_char as u8 - b'a' + 1) as i32;
        let row_val = (row_char as u8 - b'0') as i32;

        (col_val + row_val) % 2 != 0
    }
}