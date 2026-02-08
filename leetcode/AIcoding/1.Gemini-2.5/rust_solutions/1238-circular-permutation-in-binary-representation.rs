impl Solution {
    pub fn circular_permutation(n: i32, start: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let num_elements = 1 << n;

        for i in 0..num_elements {
            let gray_code_i = i ^ (i >> 1);
            result.push(gray_code_i ^ start);
        }

        result
    }
}