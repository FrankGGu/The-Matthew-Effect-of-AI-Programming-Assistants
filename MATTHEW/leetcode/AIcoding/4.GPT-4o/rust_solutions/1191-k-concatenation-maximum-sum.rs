pub fn k_concatenation_max_sum(arr: Vec<i32>, k: i32) -> i32 {
    let mod_val = 1_000_000_007;
    let n = arr.len();
    let total_sum: i32 = arr.iter().sum();
    let mut max_ending_here = 0;
    let mut max_so_far = 0;

    for &num in arr.iter() {
        max_ending_here = (max_ending_here + num).max(num);
        max_so_far = max_so_far.max(max_ending_here);
    }

    if k == 1 {
        return (max_so_far % mod_val + mod_val) % mod_val;
    }

    let max_prefix = arr.iter().scan(0, |sum, &num| {
        *sum += num;
        Some(*sum)
    }).max().unwrap_or(0);

    let max_suffix = arr.iter().rev().scan(0, |sum, &num| {
        *sum += num;
        Some(*sum)
    }).max().unwrap_or(0);

    let result = (max_so_far.max(0) + max_suffix + max_prefix + if total_sum > 0 { (k - 2) * total_sum } else { 0 }) % mod_val;

    result
}