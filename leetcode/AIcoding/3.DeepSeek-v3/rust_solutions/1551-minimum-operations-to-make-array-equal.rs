impl Solution {
    pub fn min_operations(n: i32) -> i32 {
        if n % 2 == 1 {
            let k = (n - 1) / 2;
            k * (k + 1)
        } else {
            let k = n / 2;
            k * k
        }
    }
}