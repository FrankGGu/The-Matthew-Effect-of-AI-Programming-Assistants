impl Solution {
    pub fn count_matches(items: Vec<Vec<String>>, rule_key: String, rule_value: String) -> i32 {
        let mut count = 0;
        for item in items {
            let mut index = 0;
            if rule_key == "type" {
                index = 0;
            } else if rule_key == "color" {
                index = 1;
            } else {
                index = 2;
            }

            if item[index] == rule_value {
                count += 1;
            }
        }
        count
    }
}