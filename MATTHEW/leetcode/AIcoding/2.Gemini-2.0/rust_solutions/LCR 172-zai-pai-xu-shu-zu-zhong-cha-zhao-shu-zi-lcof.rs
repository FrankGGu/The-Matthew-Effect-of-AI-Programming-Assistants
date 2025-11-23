impl Solution {
    pub fn count_matching_rule(items: Vec<Vec<String>>, rule_key: String, rule_value: String) -> i32 {
        let mut count = 0;
        for item in items {
            let key_index = match rule_key.as_str() {
                "type" => 0,
                "color" => 1,
                "name" => 2,
                _ => panic!("Invalid rule key"),
            };
            if item[key_index] == rule_value {
                count += 1;
            }
        }
        count
    }
}