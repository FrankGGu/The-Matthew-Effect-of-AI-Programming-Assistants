pub fn can_transform(nums: Vec<i32>) -> bool {
    let mut sum = 0;
    for &num in &nums {
        sum += num;
        if sum < 0 {
            return false;
        }
    }
    sum == 0
}