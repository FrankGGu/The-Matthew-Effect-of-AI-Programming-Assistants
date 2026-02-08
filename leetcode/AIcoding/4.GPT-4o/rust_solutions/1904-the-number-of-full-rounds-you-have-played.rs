impl Solution {
    pub fn number_of_rounds(start_time: String, finish_time: String) -> i32 {
        let start: Vec<i32> = start_time.split(':').map(|x| x.parse().unwrap()).collect();
        let finish: Vec<i32> = finish_time.split(':').map(|x| x.parse().unwrap()).collect();

        let start_minutes = start[0] * 60 + start[1];
        let finish_minutes = finish[0] * 60 + finish[1];

        let mut rounds = 0;

        if finish_minutes < start_minutes {
            rounds += (24 * 60 - start_minutes + finish_minutes) / 15;
        } else {
            rounds += (finish_minutes - start_minutes) / 15;
        }

        if start[1] % 15 != 0 {
            rounds -= 1;
        }

        if finish[1] % 15 != 0 {
            rounds -= 1;
        }

        rounds
    }
}