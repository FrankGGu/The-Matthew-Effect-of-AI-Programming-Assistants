use std::collections::HashSet;

impl Solution {
    pub fn replace_non_coprime_numbers(arr: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut current_gcd = 0;

        for &num in arr.iter() {
            current_gcd = gcd(current_gcd, num);
            if current_gcd == 1 {
                result.push(num);
                current_gcd = 0;
            }
        }

        result
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}