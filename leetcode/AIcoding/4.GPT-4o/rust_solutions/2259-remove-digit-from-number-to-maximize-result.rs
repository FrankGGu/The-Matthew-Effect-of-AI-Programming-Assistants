impl Solution {
    pub fn maximum_numeric_string(num: String, digit: char) -> String {
        let mut max_result = String::new();
        let mut found = false;

        for i in 0..num.len() {
            if num.chars().nth(i).unwrap() == digit.chars().next().unwrap() {
                let mut candidate = num.clone();
                candidate.replace_range(i..i + 1, "");
                if !found || candidate > max_result {
                    max_result = candidate;
                    found = true;
                }
            }
        }

        if found {
            max_result
        } else {
            num
        }
    }
}