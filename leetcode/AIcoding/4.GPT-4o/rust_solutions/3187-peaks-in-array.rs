impl Solution {
    pub fn count_peaks(arr: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = arr.len();
        if n < 3 {
            return 0;
        }
        for i in 1..(n - 1) {
            if arr[i] > arr[i - 1] && arr[i] > arr[i + 1] {
                count += 1;
            }
        }
        count
    }
}