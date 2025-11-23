impl Solution {
    pub fn maximum_sum(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n == 1 {
            return arr[0];
        }
        let mut no_delete = vec![0; n];
        let mut with_delete = vec![0; n];
        no_delete[0] = arr[0];
        with_delete[0] = 0;
        let mut max_sum = arr[0];

        for i in 1..n {
            no_delete[i] = std::cmp::max(arr[i], no_delete[i-1] + arr[i]);
            with_delete[i] = std::cmp::max(no_delete[i-1], with_delete[i-1] + arr[i]);
            max_sum = std::cmp::max(max_sum, std::cmp::max(no_delete[i], with_delete[i]));
        }

        max_sum
    }
}