pub fn maximum_balanced_subsequence_sum(s: String) -> i32 {
    let mut count = 0;
    let mut max_sum = 0;
    let mut current_sum = 0;

    for c in s.chars() {
        if c == '(' {
            count += 1;
        } else if c == ')' {
            count -= 1;
        }
        current_sum += c.to_digit(10).unwrap_or(0) as i32;
        if count == 0 {
            max_sum = max_sum.max(current_sum);
        }
    }

    max_sum
}