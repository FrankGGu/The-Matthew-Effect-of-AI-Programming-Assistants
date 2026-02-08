impl Solution {
    pub fn add_negabinary(arr1: Vec<i32>, arr2: Vec<i32>) -> Vec<i32> {
        let mut res: Vec<i32> = Vec::new();
        let mut carry = 0;
        let mut i = arr1.len() as isize - 1;
        let mut j = arr2.len() as isize - 1;

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

            let digit;
            if sum == 0 {
                digit = 0;
                carry = 0;
            } else if sum == 1 {
                digit = 1;
                carry = 0;
            } else if sum == 2 {
                digit = 0;
                carry = -1;
            } else if sum == 3 {
                digit = 1;
                carry = -1;
            } else if sum == -1 {
                digit = 1;
                carry = 1;
            } else {
                // This branch should ideally not be reached given the problem constraints
                // and the nature of negabinary addition where sum is in [-1, 3].
                unreachable!("Unexpected sum value: {}", sum);
            }
            res.push(digit);
        }

        while res.len() > 1 && *res.last().unwrap() == 0 {
            res.pop();
        }

        res.reverse();
        res
    }
}