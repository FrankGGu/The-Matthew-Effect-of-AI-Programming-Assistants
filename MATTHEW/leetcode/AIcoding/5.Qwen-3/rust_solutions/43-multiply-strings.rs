impl Solution {
    pub fn multiply(num1: String, num2: String) -> String {
        if num1 == "0" || num2 == "0" {
            return "0".to_string();
        }

        let mut result = vec![0; num1.len() + num2.len()];

        let num1: Vec<char> = num1.chars().rev().collect();
        let num2: Vec<char> = num2.chars().rev().collect();

        for i in 0..num1.len() {
            for j in 0..num2.len() {
                let digit1 = num1[i].to_digit(10).unwrap() as usize;
                let digit2 = num2[j].to_digit(10).unwrap() as usize;
                let product = digit1 * digit2;

                let pos1 = i + j;
                let pos2 = i + j + 1;

                result[pos1] += product % 10;
                result[pos2] += product / 10;

                if result[pos1] > 9 {
                    result[pos2] += result[pos1] / 10;
                    result[pos1] %= 10;
                }
            }
        }

        while result.len() > 1 && result.last() == Some(&0) {
            result.pop();
        }

        result.iter().rev().map(|&d| d.to_string()).collect()
    }
}