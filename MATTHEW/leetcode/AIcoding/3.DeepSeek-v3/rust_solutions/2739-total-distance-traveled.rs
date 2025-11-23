impl Solution {
    pub fn distance_traveled(mut main_tank: i32, mut additional_tank: i32) -> i32 {
        let mut distance = 0;
        while main_tank > 0 {
            distance += 10;
            main_tank -= 1;
            if distance % 50 == 0 && additional_tank > 0 {
                additional_tank -= 1;
                main_tank += 1;
            }
        }
        distance
    }
}