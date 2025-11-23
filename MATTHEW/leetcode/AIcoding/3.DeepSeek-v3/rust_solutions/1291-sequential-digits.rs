impl Solution {
    pub fn sequential_digits(low: i32, high: i32) -> Vec<i32> {
        let mut result = Vec::new();
        let digits = "123456789";
        let low_len = low.to_string().len();
        let high_len = high.to_string().len();

        for len in low_len..=high_len {
            for start in 0..=9 - len {
                let num_str: String = digits.chars().skip(start).take(len).collect();
                let num = num_str.parse::<i32>().unwrap();
                if num >= low && num <= high {
                    result.push(num);
                }
            }
        }

        result.sort();
        result
    }
}