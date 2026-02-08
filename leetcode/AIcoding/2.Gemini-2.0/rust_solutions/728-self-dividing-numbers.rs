impl Solution {
    pub fn self_dividing_numbers(left: i32, right: i32) -> Vec<i32> {
        let mut result = Vec::new();
        for i in left..=right {
            if Solution::is_self_dividing(i) {
                result.push(i);
            }
        }
        result
    }

    fn is_self_dividing(n: i32) -> bool {
        let mut num = n;
        while num > 0 {
            let digit = num % 10;
            if digit == 0 || n % digit != 0 {
                return false;
            }
            num /= 10;
        }
        true
    }
}