impl Solution {
    pub fn max_product(digits: i32) -> i32 {
        let mut max_product = 0;
        let digits_str = digits.to_string();

        for i in 0..digits_str.len() {
            for j in (i + 1)..digits_str.len() {
                let product = digits_str[i..i+1].parse::<i32>().unwrap() * digits_str[j..j+1].parse::<i32>().unwrap();
                max_product = max_product.max(product);
            }
        }

        max_product
    }
}