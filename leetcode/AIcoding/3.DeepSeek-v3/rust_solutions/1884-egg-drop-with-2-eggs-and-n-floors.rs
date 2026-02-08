impl Solution {
    pub fn two_egg_drop(n: i32) -> i32 {
        let mut k = 0;
        let mut sum = 0;
        while sum < n {
            k += 1;
            sum += k;
        }
        k
    }
}