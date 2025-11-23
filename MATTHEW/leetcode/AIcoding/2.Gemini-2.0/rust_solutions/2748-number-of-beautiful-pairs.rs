impl Solution {
    pub fn count_beautiful_pairs(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        for i in 0..nums.len() {
            for j in i + 1..nums.len() {
                let first_digit = nums[i].to_string().chars().next().unwrap().to_digit(10).unwrap() as i32;
                let last_digit = nums[j].to_string().chars().last().unwrap().to_digit(10).unwrap() as i32;
                if Self::gcd(first_digit, last_digit) == 1 {
                    count += 1;
                }
            }
        }
        count
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}