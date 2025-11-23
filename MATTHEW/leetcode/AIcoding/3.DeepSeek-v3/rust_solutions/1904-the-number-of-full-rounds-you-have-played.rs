impl Solution {
    pub fn number_of_rounds(login_time: String, logout_time: String) -> i32 {
        let parse_time = |s: String| -> i32 {
            let parts: Vec<&str> = s.split(':').collect();
            let hours: i32 = parts[0].parse().unwrap();
            let minutes: i32 = parts[1].parse().unwrap();
            hours * 60 + minutes
        };

        let login = parse_time(login_time);
        let logout = parse_time(logout_time);

        let (start, end) = if logout > login {
            (login, logout)
        } else {
            (login, logout + 24 * 60)
        };

        let round_start = (start + 14) / 15 * 15;
        let round_end = end / 15 * 15;

        if round_start > round_end {
            0
        } else {
            (round_end - round_start) / 15
        }
    }
}