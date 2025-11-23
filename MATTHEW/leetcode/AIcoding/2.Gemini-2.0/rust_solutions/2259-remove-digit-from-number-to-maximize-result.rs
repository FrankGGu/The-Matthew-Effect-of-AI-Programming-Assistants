impl Solution {
    pub fn remove_digit(number: String, digit: char) -> String {
        let mut res = String::new();
        let mut first_occurrence = None;

        for (i, c) in number.chars().enumerate() {
            if c == digit {
                if first_occurrence.is_none() {
                    first_occurrence = Some(i);
                }
                let mut temp = number.clone();
                temp.remove(i);
                if temp > res {
                    res = temp;
                }
            }
        }

        res
    }
}