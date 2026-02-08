pub fn find_array(sums: Vec<i32>) -> Vec<i32> {
    let n = sums.len();
    let mut result = vec![0; n - 1];
    let total_sum = sums[n - 1];

    for i in 0..n - 1 {
        result[i] = sums[i] - (if i > 0 { sums[i - 1] } else { 0 });
    }

    result.push(total_sum - result.iter().sum::<i32>());
    result
}