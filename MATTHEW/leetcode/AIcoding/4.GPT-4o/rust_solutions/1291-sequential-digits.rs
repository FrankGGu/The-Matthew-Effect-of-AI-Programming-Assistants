impl Solution {
    pub fn sequential_digits(low: i32, high: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let digits = "123456789";

        for len in 1..=9 {
            for start in 0..=9 - len {
                let num: i32 = digits[start..start + len].parse().unwrap();
                if num >= low && num <= high {
                    result.push(num);
                }
            }
        }

        result.sort();
        result
    }
}