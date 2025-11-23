impl Solution {
    pub fn diff_ways_to_compute(expression: String) -> Vec<i32> {
        let mut results = Vec::new();
        for i in 0..expression.len() {
            if expression.chars().nth(i).unwrap().is_digit(10) {
                continue;
            }
            let left = Self::diff_ways_to_compute(expression[0..i].to_string());
            let right = Self::diff_ways_to_compute(expression[i + 1..].to_string());
            for l in left.iter() {
                for r in right.iter() {
                    let result = match expression.chars().nth(i).unwrap() {
                        '+' => l + r,
                        '-' => l - r,
                        '*' => l * r,
                        _ => unreachable!(),
                    };
                    results.push(result);
                }
            }
        }
        if results.is_empty() {
            results.push(expression.parse().unwrap());
        }
        results
    }
}