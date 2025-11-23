impl Solution {
    pub fn egg_drop(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }

        let mut k = 0;
        let mut floors_covered = 0;

        while floors_covered < n {
            k += 1;
            floors_covered += k;
        }
        k
    }
}