impl Solution {
    pub fn deep_dark_fraction(mut num: i32, mut den: i32) -> Vec<i32> {
        let mut result = Vec::new();
        while den != 0 {
            result.push(num / den);
            let remainder = num % den;
            num = den;
            den = remainder;
        }
        result
    }
}