impl Solution {
    pub fn fill_cups(cups: Vec<i32>) -> i32 {
        let mut cups = cups;
        cups.sort_unstable();
        let mut time = 0;

        while cups[2] > 0 {
            cups[2] -= 1;
            time += 1;
            if cups[1] > 0 {
                cups[1] -= 1;
            }
            cups.sort_unstable();
        }

        time
    }
}