impl Solution {
    pub fn find_gcd(nums: Vec<i32>) -> i32 {
        let mut min_val = i32::MAX;
        let mut max_val = i32::MIN;

        for &num in nums.iter() {
            if num < min_val {
                min_val = num;
            }
            if num > max_val {
                max_val = num;
            }
        }

        fn calculate_gcd(mut a: i32, mut b: i32) -> i32 {
            while b != 0 {
                let temp = b;
                b = a % b;
                a = temp;
            }
            a
        }

        calculate_gcd(min_val, max_val)
    }
}