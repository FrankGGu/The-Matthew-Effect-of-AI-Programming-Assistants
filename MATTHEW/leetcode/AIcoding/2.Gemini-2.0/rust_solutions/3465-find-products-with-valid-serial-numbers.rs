use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct Product {
    product_id: i32,
    product_name: String,
}

impl Product {
    pub fn new(product_id: i32, product_name: String) -> Self {
        Product {
            product_id,
            product_name,
        }
    }
}

#[derive(Debug, PartialEq, Eq)]
pub struct Sales {
    product_id: i32,
    serial_number: String,
    sale_date: String,
}

impl Sales {
    pub fn new(product_id: i32, serial_number: String, sale_date: String) -> Self {
        Sales {
            product_id,
            serial_number,
            sale_date,
        }
    }
}

#[derive(Debug, PartialEq, Eq)]
pub struct ValidSerial {
    product_id: i32,
    serial_number: String,
}

impl ValidSerial {
    pub fn new(product_id: i32, serial_number: String) -> Self {
        ValidSerial {
            product_id,
            serial_number,
        }
    }
}

pub fn find_products_with_valid_serial_numbers(
    products: Vec<Product>,
    sales: Vec<Sales>,
    valid_serials: Vec<ValidSerial>,
) -> Vec<String> {
    let valid_serial_set: std::collections::HashSet<(i32, String)> = valid_serials
        .into_iter()
        .map(|vs| (vs.product_id, vs.serial_number))
        .collect();

    let mut valid_product_ids = std::collections::HashSet::new();

    for sale in sales {
        if valid_serial_set.contains(&(sale.product_id, sale.serial_number)) {
            valid_product_ids.insert(sale.product_id);
        }
    }

    let mut result: Vec<String> = products
        .into_iter()
        .filter(|product| valid_product_ids.contains(&product.product_id))
        .map(|product| product.product_name)
        .collect();

    result.sort();
    result
}