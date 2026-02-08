pub fn make_k_subarray_sums_equal(arr: Vec<i32>, k: i32) -> i32 {
    let n = arr.len();
    let total_sum: i32 = arr.iter().sum();
    let target_sum = total_sum / k;

    let mut prefix_sum = vec![0; n + 1];
    for i in 0..n {
        prefix_sum[i + 1] = prefix_sum[i] + arr[i];
    }

    let mut result = 0;
    for i in 0..n {
        let needed_sum = prefix_sum[i] + target_sum;
        let mut j = i + 1;
        while j <= n {
            if prefix_sum[j] == needed_sum {
                result += 1;
            }
            j += 1;
        }
    }

    result
}