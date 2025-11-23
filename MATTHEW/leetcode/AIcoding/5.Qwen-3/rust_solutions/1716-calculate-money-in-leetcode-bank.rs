pub fn total_money(weeks: i32) -> i32 {
    let mut total = 0;
    let mut current = 1;
    for week in 0..weeks {
        for day in 0..7 {
            total += current + day;
        }
        current += 7;
    }
    total
}