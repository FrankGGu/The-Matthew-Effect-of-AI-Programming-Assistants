use std::collections::HashMap;

pub fn gcd_pair_queries(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
    let mut result = Vec::new();
    let mut gcd_map: HashMap<i32, i32> = HashMap::new();
    let mut max_gcd = 0;

    for &num in &nums {
        max_gcd = max_gcd.gcd(num);
        *gcd_map.entry(num).or_insert(0) += 1;
    }

    for q in queries {
        let (l, r) = (q[0], q[1]);
        let mut current_gcd = 0;

        for (&num, &count) in &gcd_map {
            if num <= r {
                current_gcd = current_gcd.gcd(num);
            }
        }

        result.push(if current_gcd >= l { 1 } else { 0 });
    }

    result
}