impl Solution {
    pub fn prefixes_div_by5(A: Vec<i32>) -> Vec<bool> {
        let mut result = Vec::new();
        let mut num = 0;

        for bit in A {
            num = ((num << 1) + bit) % 5;
            result.push(num == 0);
        }

        result
    }
}