impl Solution {
    pub fn count_matches(items: Vec<Vec<String>>, rule_key: String, rule_value: String) -> i32 {
        let mut count = 0;
        let rule_index = match rule_key.as_str() {
            "type" => 0,
            "color" => 1,
            "name" => 2,
            _ => unreachable!(),
        };

        for item in items {
            if item[rule_index] == rule_value {
                count += 1;
            }
        }
        count
    }
}