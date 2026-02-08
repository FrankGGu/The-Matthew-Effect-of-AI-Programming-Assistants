pub fn min_positive_sum_subarray(nums: Vec<i32>) -> i32 {
    let mut min_sum = i32::MAX;
    let mut current_sum = 0;
    let mut found_positive = false;

    for &num in &nums {
        if num > 0 {
            found_positive = true;
            current_sum += num;
            min_sum = min_sum.min(current_sum);
        } else {
            current_sum = 0;
        }
    }

    if found_positive {
        min_sum
    } else {
        0
    }
}