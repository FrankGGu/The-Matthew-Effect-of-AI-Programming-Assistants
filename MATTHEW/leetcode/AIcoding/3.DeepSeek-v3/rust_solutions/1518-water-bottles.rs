impl Solution {
    pub fn num_water_bottles(num_bottles: i32, num_exchange: i32) -> i32 {
        let mut total = num_bottles;
        let mut empty = num_bottles;
        while empty >= num_exchange {
            let exchanged = empty / num_exchange;
            total += exchanged;
            empty = exchanged + empty % num_exchange;
        }
        total
    }
}