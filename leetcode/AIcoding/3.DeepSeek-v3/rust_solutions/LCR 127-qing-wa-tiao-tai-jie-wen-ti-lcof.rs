impl Solution {
    pub fn num_ways(n: i32) -> i32 {
        if n == 0 || n == 1 {
            return 1;
        }
        let mut a = 1;
        let mut b = 1;
        for _ in 2..=n {
            let c = (a + b) % 1000000007;
            a = b;
            b = c;
        }
        b
    }
}