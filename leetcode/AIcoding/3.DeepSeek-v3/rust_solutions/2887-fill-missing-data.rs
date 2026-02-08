impl Solution {
    pub fn fill_missing_values(products: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut products = products;
        let n = products.len();
        if n == 0 {
            return products;
        }

        let mut prev_quantity = None;
        let mut next_quantities = Vec::new();

        // First pass to collect next valid quantities
        let mut next_quantity = None;
        for i in (0..n).rev() {
            if products[i][1] != "NaN" {
                next_quantity = Some(products[i][1].clone());
            }
            next_quantities.push(next_quantity.clone());
        }
        next_quantities.reverse();

        // Second pass to fill missing values
        for i in 0..n {
            if products[i][1] == "NaN" {
                if let Some(prev) = prev_quantity.clone() {
                    products[i][1] = prev;
                } else if let Some(next) = next_quantities[i].clone() {
                    products[i][1] = next;
                }
            } else {
                prev_quantity = Some(products[i][1].clone());
            }
        }

        products
    }
}