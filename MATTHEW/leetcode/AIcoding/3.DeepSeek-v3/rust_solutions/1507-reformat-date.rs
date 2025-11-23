use std::collections::HashMap;

impl Solution {
    pub fn reformat_date(date: String) -> String {
        let month_map: HashMap<&str, &str> = [
            ("Jan", "01"),
            ("Feb", "02"),
            ("Mar", "03"),
            ("Apr", "04"),
            ("May", "05"),
            ("Jun", "06"),
            ("Jul", "07"),
            ("Aug", "08"),
            ("Sep", "09"),
            ("Oct", "10"),
            ("Nov", "11"),
            ("Dec", "12"),
        ].iter().cloned().collect();

        let parts: Vec<&str> = date.split_whitespace().collect();
        let day = parts[0].trim_end_matches(|c: char| !c.is_numeric());
        let day_formatted = if day.len() == 1 {
            format!("0{}", day)
        } else {
            day.to_string()
        };
        let month = month_map[parts[1]];
        let year = parts[2];

        format!("{}-{}-{}", year, month, day_formatted)
    }
}