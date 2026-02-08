impl Solution {
    pub fn add_to_array_form(num: Vec<i32>, k: i32) -> Vec<i32> {
        let mut res = Vec::new();
        let mut k = k;
        let mut i = num.len() as i32 - 1;
        let mut carry = 0;

        while i >= 0 || k > 0 || carry > 0 {
            let mut sum = carry;
            if i >= 0 {
                sum += num[i as usize];
            }
            if k > 0 {
                sum += k % 10;
                k /= 10;
            }

            res.push(sum % 10);
            carry = sum / 10;

            if i >= 0 {
                i -= 1;
            }
        }

        res.reverse();
        res
    }
}