pub fn max_equal_product(arr: Vec<i32>) -> i32 {
    use std::collections::HashMap;
    let mut count_map: HashMap<i32, i32> = HashMap::new();
    let mut result = 0;

    for &num in &arr {
        let product = num * count_map.len() as i32;
        *count_map.entry(product).or_insert(0) += 1;
        result = result.max(count_map[&product]);
    }

    result
}