impl Solution {
    pub fn find_gcd(nums: Vec<i32>) -> i32 {
        let min = *nums.iter().min().unwrap();
        let max = *nums.iter().max().unwrap();
        Self::gcd(min, max)
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}