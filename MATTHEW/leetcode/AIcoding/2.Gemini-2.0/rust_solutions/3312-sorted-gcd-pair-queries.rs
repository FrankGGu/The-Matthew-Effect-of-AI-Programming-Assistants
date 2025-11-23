use std::collections::HashMap;

impl Solution {
    pub fn sorted_gcd_pairs(nums1: Vec<i32>, nums2: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut gcd_map: HashMap<i32, Vec<i32>> = HashMap::new();
        for &num1 in &nums1 {
            for &num2 in &nums2 {
                let gcd_val = Self::gcd(num1, num2);
                gcd_map.entry(gcd_val).or_insert(Vec::new()).push(num1 * num2);
            }
        }

        for (_, values) in gcd_map.iter_mut() {
            values.sort_unstable();
        }

        let mut result: Vec<i32> = Vec::new();
        for query in queries {
            let gcd_val = query[0];
            let k = query[1] - 1;

            if let Some(values) = gcd_map.get(&gcd_val) {
                if k < values.len() as i32 {
                    result.push(values[k as usize]);
                } else {
                    result.push(-1);
                }
            } else {
                result.push(-1);
            }
        }

        result
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}