impl Solution {
    pub fn plus_one(digits: Vec<i32>) -> Vec<i32> {
        let mut result = digits;
        let mut carry = 1;

        for i in (0..result.len()).rev() {
            result[i] += carry;
            if result[i] == 10 {
                result[i] = 0;
                carry = 1;
            } else {
                carry = 0;
                break;
            }
        }

        if carry == 1 {
            result.insert(0, 1);
        }

        result
    }
}