impl Solution {
    pub fn distance_traveled(main_tank: i32, additional_tank: i32) -> i32 {
        let mut main_tank = main_tank;
        let mut additional_tank = additional_tank;
        let mut total_liters_consumed = 0;

        while main_tank >= 5 {
            total_liters_consumed += 5;
            main_tank -= 5;

            if additional_tank > 0 {
                main_tank += 1;
                additional_tank -= 1;
            }
        }

        total_liters_consumed += main_tank;

        total_liters_consumed * 10
    }
}