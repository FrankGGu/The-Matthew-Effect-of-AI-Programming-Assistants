impl Solution {
    pub fn fill_cups(mut cups: Vec<i32>) -> i32 {
        cups.sort_unstable();
        let a = cups[0];
        let b = cups[1];
        let c = cups[2];

        if a + b <= c {
            c
        } else {
            (a + b + c + 1) / 2
        }
    }
}