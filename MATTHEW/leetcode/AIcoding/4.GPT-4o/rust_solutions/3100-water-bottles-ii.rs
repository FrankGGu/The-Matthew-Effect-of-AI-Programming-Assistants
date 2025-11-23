pub fn max_drink(water: i32, num_bottles: i32, num_exchange: i32) -> i32 {
    let mut total_drunk = water;
    let mut bottles = num_bottles;

    while bottles > 0 {
        total_drunk += bottles;
        if num_exchange == 0 {
            break;
        }
        bottles = bottles / num_exchange;
    }

    total_drunk
}