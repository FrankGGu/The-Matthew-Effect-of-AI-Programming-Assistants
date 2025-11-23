struct Solution;

impl Solution {
    pub fn get_winner(arr: Vec<i32>, k: i32) -> i32 {
        let mut max_val = arr[0];
        let mut count = 0;

        for i in 1..arr.len() {
            if max_val > arr[i] {
                count += 1;
            } else {
                max_val = arr[i];
                count = 1;
            }

            if count == k {
                return max_val;
            }
        }

        max_val
    }
}