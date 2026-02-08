use std::collections::HashMap;

pub struct Product {
    pub product_id: i32,
    pub product_type: String,
    pub month: String,
    pub amount: i32,
}

pub struct PivotedProduct {
    pub product_type: String,
    pub jan_amount: Option<i32>,
    pub feb_amount: Option<i32>,
    pub mar_amount: Option<i32>,
}

pub struct Solution;

impl Solution {
    pub fn pivot_products(products: Vec<Product>) -> Vec<PivotedProduct> {
        let mut grouped_amounts: HashMap<String, HashMap<String, i32>> = HashMap::new();

        for product in products {
            grouped_amounts
                .entry(product.product_type)
                .or_default()
                .entry(product.month)
                .and_modify(|e| *e += product.amount)
                .or_insert(product.amount);
        }

        let mut pivoted_results: Vec<PivotedProduct> = Vec::new();

        for (product_type, month_amounts) in grouped_amounts {
            let jan_amount = month_amounts.get("Jan").copied();
            let feb_amount = month_amounts.get("Feb").copied();
            let mar_amount = month_amounts.get("Mar").copied();

            pivoted_results.push(PivotedProduct {
                product_type,
                jan_amount,
                feb_amount,
                mar_amount,
            });
        }

        pivoted_results.sort_by(|a, b| a.product_type.cmp(&b.product_type));

        pivoted_results
    }
}