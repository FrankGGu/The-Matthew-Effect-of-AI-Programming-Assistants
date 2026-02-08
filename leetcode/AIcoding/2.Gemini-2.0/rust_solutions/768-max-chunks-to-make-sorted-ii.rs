impl Solution {
    pub fn max_chunks_to_sorted(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut left_max = vec![0; n];
        let mut right_min = vec![0; n];

        left_max[0] = arr[0];
        for i in 1..n {
            left_max[i] = left_max[i - 1].max(arr[i]);
        }

        right_min[n - 1] = arr[n - 1];
        for i in (0..n - 1).rev() {
            right_min[i] = right_min[i + 1].min(arr[i]);
        }

        let mut count = 1;
        for i in 0..n - 1 {
            if left_max[i] <= right_min[i + 1] {
                count += 1;
            }
        }

        count
    }
}