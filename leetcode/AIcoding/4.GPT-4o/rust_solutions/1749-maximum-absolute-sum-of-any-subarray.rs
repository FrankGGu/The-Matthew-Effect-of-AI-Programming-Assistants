pub fn max_absolute_sum(nums: Vec<i32>) -> i32 {
    let mut max_ending_here = 0;
    let mut min_ending_here = 0;
    let mut max_absolute_sum = 0;

    for &num in &nums {
        max_ending_here = (max_ending_here + num).max(num);
        min_ending_here = (min_ending_here + num).min(num);
        max_absolute_sum = max_absolute_sum.max(max_ending_here.abs()).max(min_ending_here.abs());
    }

    max_absolute_sum
}