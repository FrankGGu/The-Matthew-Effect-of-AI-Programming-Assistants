pub fn max_fruits(harvest: Vec<i32>, k: i32) -> i32 {
    let n = harvest.len();
    let mut max_fruits = 0;
    let mut left = 0;
    let mut current_sum = 0;

    for right in 0..n {
        current_sum += harvest[right];

        while right - left + 1 - current_sum > k {
            current_sum -= harvest[left];
            left += 1;
        }

        max_fruits = max_fruits.max(current_sum);
    }

    max_fruits
}