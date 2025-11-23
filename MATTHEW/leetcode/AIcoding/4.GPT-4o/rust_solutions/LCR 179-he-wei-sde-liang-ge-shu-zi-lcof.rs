pub fn two_sum(prices: Vec<i32>, target: i32) -> Vec<i32> {
    let mut map = std::collections::HashMap::new();
    for (i, &price) in prices.iter().enumerate() {
        if let Some(&index) = map.get(&(target - price)) {
            return vec![index as i32, i as i32];
        }
        map.insert(price, i);
    }
    vec![]
}