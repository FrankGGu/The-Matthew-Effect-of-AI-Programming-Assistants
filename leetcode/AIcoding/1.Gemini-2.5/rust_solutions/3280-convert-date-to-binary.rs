struct Solution;

impl Solution {
    pub fn convert_date_to_binary(date: String) -> String {
        let parts: Vec<i32> = date
            .split('-')
            .map(|s| s.parse::<i32>().unwrap())
            .collect();

        let year = parts[0];
        let month = parts[1];
        let day = parts[2];

        let combined_int = year * 10000 + month * 100 + day;

        format!("{:b}", combined_int)
    }
}