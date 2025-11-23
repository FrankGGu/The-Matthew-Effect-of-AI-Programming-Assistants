impl Solution {
    pub fn minimize_result(expression: String) -> String {
        let parts: Vec<&str> = expression.split('+').collect();
        let (left, right) = (parts[0], parts[1]);
        let (num1, num2) = left.split_once('-').unwrap();
        let (num3, num4) = right.split_once('-').unwrap();

        let num1: i32 = num1.parse().unwrap();
        let num2: i32 = num2.parse().unwrap();
        let num3: i32 = num3.parse().unwrap();
        let num4: i32 = num4.parse().unwrap();

        let mut min_result = i32::MAX;
        let mut best_expression = expression.clone();

        for i in 0..=num2 {
            for j in 0..=num3 {
                let new_num1 = num1 + i;
                let new_num2 = num2 - i;
                let new_num3 = num3 - j;
                let new_num4 = num4 + j;

                let result = new_num1 * (new_num2 + new_num3 + new_num4);
                if result < min_result {
                    min_result = result;
                    best_expression = format!("{}({}+{})", num1, num2 - i, num3 + j);
                }
            }
        }

        best_expression
    }
}