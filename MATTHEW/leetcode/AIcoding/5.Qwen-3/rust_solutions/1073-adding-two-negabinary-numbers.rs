struct Solution {}

impl Solution {
    pub fn add_negabinary(a: Vec<i32>, b: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut i = a.len() as isize - 1;
        let mut j = b.len() as isize - 1;
        let mut carry = 0;

        while i >= 0 || j >= 0 || carry != 0 {
            let mut sum = carry;
            if i >= 0 {
                sum += a[i as usize];
            }
            if j >= 0 {
                sum += b[j as usize];
            }

            result.push(sum % 2);
            carry = -(sum / 2);

            i -= 1;
            j -= 1;
        }

        while result.len() > 1 && result.last() == Some(&0) {
            result.pop();
        }

        result.into_iter().rev().collect()
    }
}