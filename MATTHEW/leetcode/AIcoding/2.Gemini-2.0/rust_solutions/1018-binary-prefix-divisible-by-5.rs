impl Solution {
    pub fn prefixes_div_by5(a: Vec<i32>) -> Vec<bool> {
        let mut num: i32 = 0;
        let mut result: Vec<bool> = Vec::new();
        for &bit in &a {
            num = (num * 2 + bit) % 5;
            result.push(num == 0);
        }
        result
    }
}