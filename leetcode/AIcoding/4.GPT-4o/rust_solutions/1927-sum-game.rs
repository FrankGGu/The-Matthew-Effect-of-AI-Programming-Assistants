pub fn sum_game(num: String) -> bool {
    let mut left_sum = 0;
    let mut left_unknown = 0;
    let mut right_sum = 0;
    let mut right_unknown = 0;

    let chars: Vec<char> = num.chars().collect();
    let n = chars.len();

    for i in 0..n {
        if i < n / 2 {
            if chars[i] == '?' {
                left_unknown += 1;
            } else {
                left_sum += chars[i].to_digit(10).unwrap();
            }
        } else {
            if chars[i] == '?' {
                right_unknown += 1;
            } else {
                right_sum += chars[i].to_digit(10).unwrap();
            }
        }
    }

    let left_diff = left_sum as i32 - right_sum as i32;

    if left_unknown == 0 && right_unknown == 0 {
        return left_diff == 0;
    }

    let total_unknown = left_unknown + right_unknown;

    if total_unknown == 0 {
        return false;
    }

    let min_left = -left_unknown * 9;
    let max_left = left_unknown * 9;
    let min_right = -right_unknown * 9;
    let max_right = right_unknown * 9;

    for left in min_left..=max_left {
        let right = left_diff - left;
        if right >= min_right && right <= max_right {
            return true;
        }
    }

    false
}