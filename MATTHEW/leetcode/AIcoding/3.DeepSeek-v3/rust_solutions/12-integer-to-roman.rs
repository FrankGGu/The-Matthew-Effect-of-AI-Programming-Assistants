impl Solution {
    pub fn int_to_roman(num: i32) -> String {
        let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        let symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
        let mut num = num;
        let mut roman = String::new();

        for i in 0..values.len() {
            while num >= values[i] {
                num -= values[i];
                roman.push_str(symbols[i]);
            }
        }

        roman
    }
}