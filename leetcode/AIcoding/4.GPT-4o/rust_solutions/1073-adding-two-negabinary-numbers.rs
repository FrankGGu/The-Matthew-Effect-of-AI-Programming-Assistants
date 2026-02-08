impl Solution {
    pub fn add_negabinary(a: Vec<i32>, b: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut carry = 0;
        let mut i = a.len() as i32 - 1;
        let mut j = b.len() as i32 - 1;

        while i >= 0 || j >= 0 || carry != 0 {
            let sum = carry 
                + if i >= 0 { a[i as usize] } else { 0 }
                + if j >= 0 { b[j as usize] } else { 0 };
            carry = sum / -2;
            let digit = (sum % -2 + 2) % 2;
            result.push(digit);
            i -= 1;
            j -= 1;
        }

        while result.len() > 1 && *result.last().unwrap() == 0 {
            result.pop();
        }

        result.reverse();
        result
    }
}