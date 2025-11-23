impl Solution {
    pub fn max_absolute_value_expression(arr1: Vec<i32>, arr2: Vec<i32>) -> i32 {
        let n = arr1.len();
        let mut max_value = 0;

        for &sign1 in &[1, -1] {
            for &sign2 in &[1, -1] {
                let mut current_value = 0;
                for i in 0..n {
                    current_value = (sign1 * arr1[i] + sign2 * arr2[i]).abs();
                    max_value = max_value.max(current_value);
                }
            }
        }
        max_value
    }
}