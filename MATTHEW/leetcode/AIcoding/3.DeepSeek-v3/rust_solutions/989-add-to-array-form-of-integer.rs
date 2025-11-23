impl Solution {
    pub fn add_to_array_form(num: Vec<i32>, k: i32) -> Vec<i32> {
        let mut k = k;
        let mut num = num;
        let mut carry = 0;
        let mut i = num.len() as i32 - 1;

        while i >= 0 || k > 0 || carry > 0 {
            let digit = if i >= 0 { num[i as usize] } else { 0 };
            let sum = digit + k % 10 + carry;
            carry = sum / 10;
            if i >= 0 {
                num[i as usize] = sum % 10;
            } else {
                num.insert(0, sum % 10);
            }
            k /= 10;
            i -= 1;
        }

        num
    }
}