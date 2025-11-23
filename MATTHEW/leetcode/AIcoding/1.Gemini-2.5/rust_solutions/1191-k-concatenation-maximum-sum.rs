impl Solution {
    fn kadane(arr: &[i32]) -> i64 {
        if arr.is_empty() {
            return 0;
        }

        let mut max_so_far = arr[0] as i64;
        let mut current_max = arr[0] as i64;

        for i in 1..arr.len() {
            current_max = (arr[i] as i64).max(current_max + arr[i] as i64);
            max_so_far = max_so_far.max(current_max);
        }
        max_so_far
    }

    pub fn k_concatenation_max_sum(arr: Vec<i32>, k: i32) -> i32 {
        let modulo: i64 = 1_000_000_007;

        let arr_sum: i64 = arr.iter().map(|&x| x as i64).sum();
        let max_sum_one_concat = Self::kadane(&arr);

        let mut result: i64;

        if k == 1 {
            result = max_sum_one_concat;
        } else {
            let arr_double: Vec<i32> = arr.iter().chain(arr.iter()).cloned().collect();
            let max_sum_two_concat = Self::kadane(&arr_double);

            if arr_sum > 0 {
                result = max_sum_two_concat + (k as i64 - 2) * arr_sum;
            } else {
                result = max_sum_two_concat;
            }
        }

        (result.max(0) % modulo) as i32
    }
}