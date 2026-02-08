pub struct Solution {}

impl Solution {
    pub fn abbreviate_product(low: i32, high: i32) -> String {
        let mut product = 1;
        let mut zero_count = 0;
        let mut non_zero_digits = Vec::new();

        for i in low..=high {
            product *= i;
            while product % 10 == 0 {
                product /= 10;
                zero_count += 1;
            }
        }

        let product_str = product.to_string();
        let start = if product_str.len() > 10 { &product_str[0..5] } else { &product_str };
        let end = if product_str.len() > 10 { &product_str[product_str.len()-5..] } else { "" };

        format!("{}...{}{}", start, end, "0".repeat(zero_count))
    }
}