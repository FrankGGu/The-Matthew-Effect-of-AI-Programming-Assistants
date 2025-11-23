impl Solution {
    pub fn day_of_the_week(day: i32, month: i32, year: i32) -> String {
        let mut y = year;
        let mut m = month;

        if m < 3 {
            m += 12;
            y -= 1;
        }

        let k = y % 100;
        let j = y / 100;

        let f = day + (13 * (m + 1)) / 5 + k + k / 4 + j / 4 + 5 * j;
        let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

        days[(f % 7) as usize].to_string()
    }
}