#[derive(Debug, PartialEq, Eq, Clone)]
pub struct Product {
    pub product_id: i32,
    pub serial_number: String,
}

impl Solution {
    pub fn find_products_with_valid_serial_numbers(products: Vec<Product>) -> Vec<Product> {
        products
            .into_iter()
            .filter(|product| {
                // Example validation rule:
                // A serial number is considered valid if it is not empty
                // and consists only of ASCII digits.
                !product.serial_number.is_empty()
                    && product.serial_number.chars().all(|c| c.is_ascii_digit())
            })
            .collect()
    }
}

pub struct Solution;