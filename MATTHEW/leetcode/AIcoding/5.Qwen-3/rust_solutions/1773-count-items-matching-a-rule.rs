struct Solution;

impl Solution {
    pub fn count_matches(items: Vec<Vec<String>>, rule_key: String) -> i32 {
        let index = match rule_key.as_str() {
            "type" => 0,
            "color" => 1,
            "name" => 2,
            _ => 0,
        };

        items.into_iter().filter(|item| item[index] == "yes").count() as i32
    }
}