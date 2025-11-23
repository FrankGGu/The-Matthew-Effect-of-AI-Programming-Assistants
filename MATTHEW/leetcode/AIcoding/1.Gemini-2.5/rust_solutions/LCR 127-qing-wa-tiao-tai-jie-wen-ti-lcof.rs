impl Solution {
    pub fn two_egg_drop(n: i32) -> i32 {
        let mut m = 0;
        let mut floors_covered = 0;
        while floors_covered < n {
            m += 1;
            floors_covered += m;
        }
        m
    }
}