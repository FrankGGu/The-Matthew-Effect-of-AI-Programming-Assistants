impl Solution {
    pub fn convert_date(date: String) -> String {
        let parts: Vec<&str> = date.split('-').collect();
        let day = parts[2].parse::<u32>().unwrap();
        let month = parts[1].parse::<u32>().unwrap();
        format!("{:05b}{:04b}", day, month)
    }
}