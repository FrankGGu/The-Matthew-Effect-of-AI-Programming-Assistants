impl Solution {
    pub fn max_turbulence_size(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n == 1 {
            return 1;
        }
        let mut res = 1;
        let mut inc = 1;
        let mut dec = 1;
        for i in 1..n {
            if arr[i] > arr[i - 1] {
                inc = dec + 1;
                dec = 1;
            } else if arr[i] < arr[i - 1] {
                dec = inc + 1;
                inc = 1;
            } else {
                inc = 1;
                dec = 1;
            }
            res = res.max(inc.max(dec));
        }
        res
    }
}