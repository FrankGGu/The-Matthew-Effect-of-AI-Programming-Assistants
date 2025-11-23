impl Solution {
    pub fn max_ascending_sum(arr: Vec<i32>) -> i32 {
        let mut max_sum = 0;
        let mut current_sum = 0;

        for i in 0..arr.len() {
            if i == 0 || arr[i] > arr[i - 1] {
                current_sum += arr[i];
            } else {
                max_sum = max_sum.max(current_sum);
                current_sum = arr[i];
            }
        }

        max_sum.max(current_sum)
    }
}