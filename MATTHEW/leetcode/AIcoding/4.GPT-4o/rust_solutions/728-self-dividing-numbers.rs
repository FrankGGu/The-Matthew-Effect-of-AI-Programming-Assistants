impl Solution {
    pub fn self_dividing_numbers(left: i32, right: i32) -> Vec<i32> {
        let mut result = Vec::new();
        for num in left..=right {
            let mut temp = num;
            let mut is_self_dividing = true;
            while temp > 0 {
                let digit = temp % 10;
                if digit == 0 || num % digit != 0 {
                    is_self_dividing = false;
                    break;
                }
                temp /= 10;
            }
            if is_self_dividing {
                result.push(num);
            }
        }
        result
    }
}