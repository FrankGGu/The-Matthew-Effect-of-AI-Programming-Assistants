impl Solution {
    pub fn check_powers_of_three(n: i32) -> bool {
        let mut num = n;
        while num > 0 {
            let remainder = num % 3;
            if remainder == 2 {
                return false;
            }
            num /= 3;
        }
        true
    }
}