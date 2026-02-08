impl Solution {
    pub fn is_power_of_three(n: i32) -> bool {
        if n <= 0 {
            return false;
        }
        let max_power_of_three: i32 = 3_i32.pow(19);
        n > 0 && max_power_of_three % n == 0
    }
}