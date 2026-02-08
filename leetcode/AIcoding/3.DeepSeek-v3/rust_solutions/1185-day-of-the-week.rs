impl Solution {
    pub fn day_of_the_week(day: i32, month: i32, year: i32) -> String {
        let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        let (m, y) = if month < 3 { (month + 12, year - 1) } else { (month, year) };
        let c = y / 100;
        let y = y % 100;
        let w = (c / 4 - 2 * c + y + y / 4 + 13 * (m + 1) / 5 + day - 1) % 7;
        let w = if w < 0 { w + 7 } else { w };
        days[w as usize].to_string()
    }
}