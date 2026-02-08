pub fn count_digit_one(n: i32) -> i32 {
    let mut count = 0;
    let mut factor = 1;
    let mut lower_numbers = 0;
    let mut current_digit = 0;
    let mut higher_numbers = n;

    while higher_numbers > 0 {
        current_digit = higher_numbers % 10;
        higher_numbers /= 10;

        count += higher_numbers * factor;

        if current_digit == 1 {
            count += lower_numbers + 1;
        } else if current_digit > 1 {
            count += factor;
        }

        lower_numbers = lower_numbers + current_digit * factor;
        factor *= 10;
    }

    count
}