impl Solution {
    pub fn gray_code(n: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let num_elements = 1 << n;

        for i in 0..num_elements {
            result.push(i ^ (i >> 1));
        }

        result
    }
}