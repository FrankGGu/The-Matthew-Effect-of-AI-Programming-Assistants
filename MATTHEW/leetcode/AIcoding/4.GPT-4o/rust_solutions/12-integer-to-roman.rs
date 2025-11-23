impl Solution {
    pub fn int_to_roman(num: i32) -> String {
        let values = vec![1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        let symbols = vec![
            "M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I",
        ];

        let mut result = String::new();
        let mut n = num;

        for (value, symbol) in values.iter().zip(symbols.iter()) {
            while n >= *value {
                result.push_str(symbol);
                n -= value;
            }
        }

        result
    }
}