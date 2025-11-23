impl Solution {
    pub fn convert_date_to_binary(date: String) -> String {
        let parts: Vec<&str> = date.split(" ").collect();
        let day = parts[0];
        let month = parts[1];
        let year = parts[2];

        let day_num = if day.len() == 3 {
            day[..1].parse::<i32>().unwrap()
        } else {
            day[..2].parse::<i32>().unwrap()
        };

        let month_num = match month {
            "Jan" => 1,
            "Feb" => 2,
            "Mar" => 3,
            "Apr" => 4,
            "May" => 5,
            "Jun" => 6,
            "Jul" => 7,
            "Aug" => 8,
            "Sep" => 9,
            "Oct" => 10,
            "Nov" => 11,
            "Dec" => 12,
            _ => 0,
        };

        let year_num = year.parse::<i32>().unwrap();

        format!("{:08b}{:04b}{:05b}", year_num, month_num, day_num)
    }
}