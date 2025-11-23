impl Solution {
    pub fn maximum_sum(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut max_sum = arr[0];
        let mut max_sum_with_deletion = 0;
        let mut current_sum = arr[0];

        for i in 1..n {
            current_sum = current_sum.max(arr[i]);
            max_sum_with_deletion = max_sum_with_deletion.max(current_sum);
            current_sum = current_sum + arr[i];

            max_sum = max_sum.max(current_sum);
            if i > 0 {
                max_sum = max_sum.max(max_sum_with_deletion + arr[i]);
            }
        }

        max_sum
    }
}