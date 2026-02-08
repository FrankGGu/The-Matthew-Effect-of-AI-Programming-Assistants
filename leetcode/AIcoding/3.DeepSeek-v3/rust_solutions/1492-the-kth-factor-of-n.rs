impl Solution {
    pub fn kth_factor(n: i32, k: i32) -> i32 {
        let mut factors = Vec::new();
        for i in 1..=n {
            if n % i == 0 {
                factors.push(i);
                if factors.len() == k as usize {
                    return i;
                }
            }
        }
        -1
    }
}