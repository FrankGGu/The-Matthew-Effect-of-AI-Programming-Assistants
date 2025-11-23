impl Solution {
    pub fn smallest_divisible_digit_product(a: i32, b: i32) -> String {
        if a == 0 {
            return "0".to_string();
        }
        let mut q = std::collections::VecDeque::new();
        q.push_back((1, String::new()));
        let mut visited = std::collections::HashSet::new();
        visited.insert(1);

        while !q.is_empty() {
            let (prod, s) = q.pop_front().unwrap();

            if prod >= a && prod <= b {
                return s;
            }

            for i in 2..=9 {
                let next_prod = prod * i;
                if next_prod > b {
                    continue;
                }

                if !visited.contains(&next_prod) {
                    visited.insert(next_prod);
                    q.push_back((next_prod, s.clone() + &i.to_string()));
                }
            }
        }

        "-1".to_string()
    }
}