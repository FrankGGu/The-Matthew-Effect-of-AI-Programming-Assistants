impl Solution {
    pub fn max_product(s: String) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();
        let mut max_prod = 0;

        for i in 1..n {
            let num1_str = &chars[0..i].iter().collect::<String>();
            let num2_str = &chars[i..n].iter().collect::<String>();

            if num1_str.len() > 0 && num2_str.len() > 0 && !num1_str.starts_with("0") && !num2_str.starts_with("0"){
                if num1_str.len() > 1 && num1_str.starts_with("0") {
                    continue;
                }

                if num2_str.len() > 1 && num2_str.starts_with("0") {
                    continue;
                }

            if let (Ok(num1), Ok(num2)) = (num1_str.parse::<i32>(), num2_str.parse::<i32>()) {
                max_prod = max_prod.max(num1 * num2);
            }
            }
        }

        max_prod
    }
}