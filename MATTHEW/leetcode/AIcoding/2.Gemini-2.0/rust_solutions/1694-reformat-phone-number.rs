impl Solution {
    pub fn reformat_number(number: String) -> String {
        let mut digits: Vec<char> = number.chars().filter(|c| c.is_digit(10)).collect();
        let mut result: Vec<String> = Vec::new();

        while digits.len() > 4 {
            let mut group = String::new();
            for _ in 0..3 {
                group.push(digits.remove(0));
            }
            result.push(group);
        }

        if digits.len() == 4 {
            let mut group1 = String::new();
            group1.push(digits.remove(0));
            group1.push(digits.remove(0));
            result.push(group1);

            let mut group2 = String::new();
            group2.push(digits.remove(0));
            group2.push(digits.remove(0));
            result.push(group2);
        } else if digits.len() == 3 {
            let mut group = String::new();
            for _ in 0..3 {
                group.push(digits.remove(0));
            }
            result.push(group);
        } else if digits.len() == 2 {
            let mut group = String::new();
            for _ in 0..2 {
                group.push(digits.remove(0));
            }
            result.push(group);
        } else if digits.len() == 1 {
            let mut group = String::new();
            group.push(digits.remove(0));
            result.push(group);
        }

        result.join("-")
    }
}