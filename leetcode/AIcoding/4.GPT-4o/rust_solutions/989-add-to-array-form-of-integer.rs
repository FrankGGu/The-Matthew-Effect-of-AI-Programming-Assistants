impl Solution {
    pub fn add_to_array_form(num: Vec<i32>, k: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let mut carry = k;
        let mut i = num.len() as isize - 1;

        while i >= 0 || carry > 0 {
            let mut sum = carry;
            if i >= 0 {
                sum += num[i as usize];
            }
            result.push(sum % 10);
            carry = sum / 10;
            i -= 1;
        }

        result.reverse();
        result
    }
}