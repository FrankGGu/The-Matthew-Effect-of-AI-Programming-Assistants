impl Solution {
    pub fn add_to_array_form(num: Vec<i32>, k: i32) -> Vec<i32> {
        let mut result: Vec<i32> = Vec::new();
        let mut carry = 0;
        let mut k_mutable = k;
        let mut i = num.len() as i32 - 1;

        while i >= 0 || k_mutable > 0 || carry > 0 {
            let mut sum = carry;
            if i >= 0 {
                sum += num[i as usize];
            }
            if k_mutable > 0 {
                sum += k_mutable % 10;
                k_mutable /= 10;
            }

            result.push(sum % 10);
            carry = sum / 10;

            if i >= 0 {
                i -= 1;
            }
        }

        result.reverse();
        result
    }
}