pub fn matrix_sum(nums: Vec<Vec<i32>>) -> i32 {
    let mut nums = nums;
    for row in nums.iter_mut() {
        row.sort_unstable();
    }
    let n = nums[0].len();
    let mut sum = 0;
    for i in 0..n {
        let max_val = nums.iter().map(|row| row[row.len() - 1 - i]).sum::<i32>();
        sum += max_val;
    }
    sum
}