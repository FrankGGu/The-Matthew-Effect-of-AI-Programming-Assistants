use std::collections::HashMap;

pub struct SaleRecord {
    pub product_id: i32,
    pub sale_date: String, // Format: YYYY-MM-DD
    pub price: i32,
}

pub struct ProductRecord {
    pub product_id: i32,
    pub product_name: String,
}

struct Solution;

impl Solution {
    pub fn seasonal_sales_analysis(sales: Vec<SaleRecord>, products: Vec<ProductRecord>) -> Vec<Vec<String>> {
        let mut product_names: HashMap<i32, String> = HashMap::new();
        for p in products {
            product_names.insert(p.product_id, p.product_name);
        }

        let mut product_sales: HashMap<i32, i32> = HashMap::new();

        for sale in sales {
            if sale.sale_date.starts_with("2019") {
                *product_sales.entry(sale.product_id).or_insert(0) += sale.price;
            }
        }

        let mut temp_results: Vec<(i32, String, i32)> = Vec::new();

        for (product_id, total_sales) in product_sales {
            if let Some(product_name) = product_names.get(&product_id) {
                temp_results.push((product_id, product_name.clone(), total_sales));
            }
        }

        temp_results.sort_by_key(|k| k.0);

        let mut result: Vec<Vec<String>> = Vec::new();
        for (_, product_name, total_sales) in temp_results {
            result.push(vec![product_name, total_sales.to_string()]);
        }

        result
    }
}