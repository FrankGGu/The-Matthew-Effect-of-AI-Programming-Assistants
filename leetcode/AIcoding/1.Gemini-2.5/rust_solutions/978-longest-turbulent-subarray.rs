impl Solution {
    pub fn max_turbulent_subarray_size(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n == 1 {
            return 1;
        }

        let mut max_len = 1;
        let mut inc_len = 1;
        let mut dec_len = 1;

        for i in 1..n {
            if arr[i] > arr[i - 1] {
                inc_len = dec_len + 1;
                dec_len = 1;
            } else if arr[i] < arr[i - 1] {
                dec_len = inc_len + 1;
                inc_len = 1;
            } else {
                inc_len = 1;
                dec_len = 1;
            }
            max_len = max_len.max(inc_len).max(dec_len);
        }

        max_len
    }
}