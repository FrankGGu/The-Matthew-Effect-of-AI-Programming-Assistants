impl Solution {
    pub fn find_gcd(nums: Vec<i32>) -> i32 {
        fn gcd(a: i32, b: i32) -> i32 {
            if b == 0 {
                a
            } else {
                gcd(b, a % b)
            }
        }

        let min_num = *nums.iter().min().unwrap();
        let max_num = *nums.iter().max().unwrap();
        gcd(max_num, min_num)
    }
}