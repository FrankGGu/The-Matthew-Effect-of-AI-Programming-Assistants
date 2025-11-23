pub fn num_subarrays_with_zeroes(nums: Vec<i32>) -> i64 {
    let mut count = 0;
    let mut current = 0;
    for &num in &nums {
        if num == 0 {
            current += 1;
            count += current;
        } else {
            current = 0;
        }
    }
    count
}

pub fn num_zero_filled_subarrays(nums: Vec<i32>) -> i64 {
    num_subarrays_with_zeroes(nums)
}