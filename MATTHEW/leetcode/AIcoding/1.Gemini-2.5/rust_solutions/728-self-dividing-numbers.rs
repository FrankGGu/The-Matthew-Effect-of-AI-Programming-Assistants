impl Solution {
    pub fn self_dividing_numbers(left: i32, right: i32) -> Vec<i32> {
        let mut result = Vec::new();
        for num in left..=right {
            if Self::is_self_dividing(num) {
                result.push(num);
            }
        }
        result
    }

    fn is_self_dividing(n: i32) -> bool {
        let mut temp = n;
        while temp > 0 {
            let digit = temp % 10;
            if digit == 0 || n % digit != 0 {
                return false;
            }
            temp /= 10;
        }
        true
    }
}