struct Solution {}

impl Solution {
    pub fn two_egg_drop(n: i32) -> i32 {
        let mut k = 1;
        while (k * (k + 1)) / 2 < n {
            k += 1;
        }
        k
    }
}