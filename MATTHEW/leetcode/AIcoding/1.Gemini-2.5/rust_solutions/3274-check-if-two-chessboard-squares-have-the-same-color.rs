impl Solution {
    pub fn squares_are_same_color(square1: String, square2: String) -> bool {
        let c1 = square1.as_bytes()[0] - b'a';
        let r1 = square1.as_bytes()[1] - b'1';
        let parity1 = (c1 + r1) % 2;

        let c2 = square2.as_bytes()[0] - b'a';
        let r2 = square2.as_bytes()[1] - b'1';
        let parity2 = (c2 + r2) % 2;

        parity1 == parity2
    }
}