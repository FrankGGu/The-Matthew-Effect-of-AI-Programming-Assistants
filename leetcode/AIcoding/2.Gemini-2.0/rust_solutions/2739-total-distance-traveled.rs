impl Solution {
    pub fn distance_traveled(main_tank: i32, additional_tank: i32) -> i32 {
        let mut main = main_tank;
        let mut additional = additional_tank;
        let mut distance = 0;

        while main > 0 {
            if main >= 5 && additional > 0 {
                distance += 50;
                main -= 5;
                additional -= 1;
                main += 1;
            } else {
                distance += main * 10;
                main = 0;
            }
        }

        distance
    }
}