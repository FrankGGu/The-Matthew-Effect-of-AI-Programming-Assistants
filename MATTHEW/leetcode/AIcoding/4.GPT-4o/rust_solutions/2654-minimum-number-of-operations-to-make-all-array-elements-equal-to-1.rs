pub fn min_operations(nums: Vec<i32>) -> i32 {
    let mut operations = 0;
    let mut found_one = false;

    for &num in &nums {
        if num == 1 {
            found_one = true;
            break;
        }
    }

    if found_one {
        return 0;
    }

    for &num in &nums {
        if num > 1 {
            operations += (num as f64).log(2.0).ceil() as i32;
        }
    }

    operations + nums.len() as i32
}