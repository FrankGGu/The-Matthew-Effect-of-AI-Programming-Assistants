impl Solution {
    pub fn sort_array_by_parity_ii(a: Vec<i32>) -> Vec<i32> {
        let mut result = vec![0; a.len()];
        let (mut even_index, mut odd_index) = (0, 1);

        for &num in &a {
            if num % 2 == 0 {
                result[even_index] = num;
                even_index += 2;
            } else {
                result[odd_index] = num;
                odd_index += 2;
            }
        }

        result
    }
}