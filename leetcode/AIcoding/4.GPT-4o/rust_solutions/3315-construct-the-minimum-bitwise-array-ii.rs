pub fn minimum_bitwise_array(mut nums: Vec<i32>) -> Vec<i32> {
    let n = nums.len();
    let mut result = vec![0; n];
    let mut mask = 0;

    for &num in &nums {
        mask |= num;
    }

    for i in 0..n {
        result[i] = mask & !nums[i];
    }

    result
}