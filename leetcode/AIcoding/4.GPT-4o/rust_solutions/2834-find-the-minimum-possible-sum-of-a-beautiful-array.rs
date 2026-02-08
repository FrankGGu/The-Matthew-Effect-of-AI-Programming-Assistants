impl Solution {
    pub fn min_beautiful_array(n: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let mut x = n;

        while x > 0 {
            result.push(x);
            x /= 2;
        }

        result.reverse();
        result
    }
}