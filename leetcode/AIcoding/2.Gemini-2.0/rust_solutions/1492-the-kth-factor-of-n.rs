impl Solution {
    pub fn kth_factor(n: i32, k: i32) -> i32 {
        let mut factors: Vec<i32> = Vec::new();
        for i in 1..=(n as f64).sqrt() as i32 {
            if n % i == 0 {
                factors.push(i);
                if i != n / i {
                    factors.push(n / i);
                }
            }
        }
        factors.sort();
        if (k as usize) <= factors.len() {
            factors[(k - 1) as usize]
        } else {
            -1
        }
    }
}