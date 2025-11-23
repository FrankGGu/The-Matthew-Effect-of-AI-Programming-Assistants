impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn find_product_recommendation_pairs(purchases: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut product_map = HashMap::new();

        for purchase in &purchases {
            for &product in purchase {
                product_map.entry(product).or_insert_with(Vec::new);
            }
        }

        for purchase in &purchases {
            let mut products: Vec<_> = purchase.iter().collect();
            products.sort();

            for i in 0..products.len() {
                for j in i + 1..products.len() {
                    let a = products[i];
                    let b = products[j];

                    if a != b {
                        let pair = if a < b { vec![a, b] } else { vec![b, a] };
                        let count = product_map.get_mut(&a).unwrap();
                        *count = count.iter().map(|x| x + 1).collect();

                        let count_b = product_map.get_mut(&b).unwrap();
                        *count_b = count_b.iter().map(|x| x + 1).collect();

                        let common = product_map.get_mut(&a).unwrap();
                        *common = common.iter().map(|x| x + 1).collect();

                        let common_b = product_map.get_mut(&b).unwrap();
                        *common_b = common_b.iter().map(|x| x + 1).collect();
                    }
                }
            }
        }

        let mut result = Vec::new();
        for (product, count) in &product_map {
            if *count != 0 {
                result.push(vec![*product, *count]);
            }
        }

        result
    }
}
}