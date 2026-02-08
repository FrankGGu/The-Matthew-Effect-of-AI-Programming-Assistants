use std::collections::VecDeque;

impl Solution {
    pub fn add_two_numbers(l1: Vec<i32>, l2: Vec<i32>) -> Vec<i32> {
        let mut stack1 = VecDeque::from(l1);
        let mut stack2 = VecDeque::from(l2);
        let mut result = Vec::new();
        let mut carry = 0;

        while !stack1.is_empty() || !stack2.is_empty() || carry > 0 {
            let mut sum = carry;
            if let Some(num) = stack1.pop_back() {
                sum += num;
            }
            if let Some(num) = stack2.pop_back() {
                sum += num;
            }
            carry = sum / 10;
            result.push(sum % 10);
        }

        result.reverse();
        result
    }
}