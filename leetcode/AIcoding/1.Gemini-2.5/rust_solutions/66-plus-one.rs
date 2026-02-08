impl Solution {
    pub fn plus_one(mut digits: Vec<i32>) -> Vec<i32> {
        let n = digits.len();
        for i in (0..n).rev() {
            if digits[i] < 9 {
                digits[i] += 1;
                return digits;
            } else {
                digits[i] = 0;
            }
        }

        let mut result = vec![1];
        result.extend(digits);
        result
    }
}