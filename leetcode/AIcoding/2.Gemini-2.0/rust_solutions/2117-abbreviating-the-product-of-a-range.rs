impl Solution {
    pub fn abbreviate_product(left: i32, right: i32) -> String {
        let mut product: f64 = 1.0;
        let mut trailing_zeros: i64 = 0;
        let mut small_product: i64 = 1;

        for i in left..=right {
            let mut num = i;
            while num % 2 == 0 {
                trailing_zeros += 1;
                num /= 2;
            }
            while num % 5 == 0 {
                trailing_zeros += 1;
                num /= 5;
            }
            small_product = (small_product * num) % 100000;
            product *= i as f64;
            if product.is_infinite() {
                break;
            }
        }

        if product.is_infinite() {
            let s = small_product.to_string();
            let prefix = product.log10() as i64;
            let prefix_str = format!("{:.5}", product / 10.0_f64.powi(prefix as i32 - 5));
            let formatted_prefix = prefix_str.split('.').next().unwrap().to_string();
            let mut padded_small_product = s.to_string();
            while padded_small_product.len() < 5 {
                padded_small_product = "0".to_string() + &padded_small_product;
            }
            format!("{}...{}e{}", formatted_prefix, padded_small_product, trailing_zeros)
        } else {
            format!("{}e{}", small_product, trailing_zeros)
        }
    }
}