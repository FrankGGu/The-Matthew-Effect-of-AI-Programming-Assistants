pub fn maximize_sum(nums: Vec<i32>, remove: i32) -> i32 {
    let mut sum = 0;
    let mut count = 0;
    for &num in &nums {
        if num != remove {
            sum += num;
            count += 1;
        }
    }

    if count == 0 {
        return 0;
    }

    let mut max_sum = sum;
    let mut current_sum = sum;

    for &num in &nums {
        if num == remove {
            current_sum = (current_sum - num).max(0);
            if current_sum > max_sum {
                max_sum = current_sum;
            }
        }
    }

    max_sum
}