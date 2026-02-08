impl Solution {
    pub fn k_concatenation_max_sum(arr: Vec<i32>, k: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let n = arr.len();
        let total_sum: i64 = arr.iter().map(|&x| x as i64).sum();
        let mut max_prefix = 0;
        let mut prefix_sum = 0;
        for &num in &arr {
            prefix_sum += num as i64;
            max_prefix = max_prefix.max(prefix_sum);
        }
        let mut max_suffix = 0;
        let mut suffix_sum = 0;
        for &num in arr.iter().rev() {
            suffix_sum += num as i64;
            max_suffix = max_suffix.max(suffix_sum);
        }
        let mut max_subarray = 0;
        let mut current = 0;
        for &num in &arr {
            current = (current + num as i64).max(num as i64);
            max_subarray = max_subarray.max(current);
        }
        if k == 1 {
            return (max_subarray % mod_val) as i32;
        }
        let max_two_arrays = (max_prefix + max_suffix).max(max_subarray);
        if total_sum <= 0 {
            return (max_two_arrays % mod_val) as i32;
        }
        let res = max_two_arrays.max(max_subarray.max(total_sum * (k as i64 - 2) + max_prefix + max_suffix));
        (res % mod_val) as i32
    }
}