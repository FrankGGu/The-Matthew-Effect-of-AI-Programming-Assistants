impl Solution {
    pub fn number_of_rounds(start_time: String, finish_time: String) -> i32 {
        fn to_minutes(time: &String) -> i32 {
            let parts: Vec<&str> = time.split(':').collect();
            parts[0].parse::<i32>().unwrap() * 60 + parts[1].parse::<i32>().unwrap()
        }

        let start_minutes = to_minutes(&start_time);
        let finish_minutes = to_minutes(&finish_time);

        let mut diff = finish_minutes - start_minutes;

        if diff < 0 {
            diff += 24 * 60;
        }

        let start_minutes_rounded_up = (start_minutes + 14) / 15 * 15;
        let finish_minutes_rounded_down = finish_minutes / 15 * 15;

        let mut rounds = 0;

        if start_minutes_rounded_up <= finish_minutes_rounded_down {
            rounds = (finish_minutes_rounded_down - start_minutes_rounded_up) / 15;
        }

        rounds
    }
}