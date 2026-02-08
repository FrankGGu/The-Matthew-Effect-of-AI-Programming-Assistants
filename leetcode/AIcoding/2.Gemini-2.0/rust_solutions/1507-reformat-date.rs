impl Solution {
    pub fn reformat_date(date: String) -> String {
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        let parts: Vec<&str> = date.split_whitespace().collect();
        let day = parts[0].trim_end_matches(|c: char| !c.is_digit(10));
        let month = parts[1];
        let year = parts[2];

        let month_num = months.iter().position(|&m| m == month).unwrap() + 1;
        let month_str = format!("{:02}", month_num);

        format!("{}-{}-{}", year, month_str, format!("{:02}", day.parse::<i32>().unwrap()))
    }
}