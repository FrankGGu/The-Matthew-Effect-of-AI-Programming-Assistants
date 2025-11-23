impl Solution {
    pub fn add_negabinary(arr1: Vec<i32>, arr2: Vec<i32>) -> Vec<i32> {
        let mut res = Vec::new();
        let mut i = arr1.len() as i32 - 1;
        let mut j = arr2.len() as i32 - 1;
        let mut carry = 0;

        while i >= 0 || j >= 0 || carry != 0 {
            let mut sum = carry;
            if i >= 0 {
                sum += arr1[i as usize];
                i -= 1;
            }
            if j >= 0 {
                sum += arr2[j as usize];
                j -= 1;
            }

            res.push(sum & 1);
            carry = -(sum >> 1);
        }

        while res.len() > 1 && res.last() == Some(&0) {
            res.pop();
        }

        res.reverse();
        res
    }
}