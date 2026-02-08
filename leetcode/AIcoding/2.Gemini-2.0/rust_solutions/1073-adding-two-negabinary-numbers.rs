impl Solution {
    pub fn add_negabinary(arr1: Vec<i32>, arr2: Vec<i32>) -> Vec<i32> {
        let mut i = arr1.len() as i32 - 1;
        let mut j = arr2.len() as i32 - 1;
        let mut carry = 0;
        let mut result = Vec::new();

        while i >= 0 || j >= 0 || carry != 0 {
            let x = if i >= 0 { arr1[i as usize] } else { 0 };
            let y = if j >= 0 { arr2[j as usize] } else { 0 };

            let sum = x + y + carry;

            match sum {
                0 => {
                    result.push(0);
                    carry = 0;
                }
                1 => {
                    result.push(1);
                    carry = 0;
                }
                2 => {
                    result.push(0);
                    carry = -1;
                }
                3 => {
                    result.push(1);
                    carry = -1;
                }
                -1 => {
                    result.push(1);
                    carry = 1;
                }
                _ => {}
            }

            i -= 1;
            j -= 1;
        }

        while result.len() > 1 && result.last() == Some(&0) {
            result.pop();
        }

        result.reverse();
        result
    }
}