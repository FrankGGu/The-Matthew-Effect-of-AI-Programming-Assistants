impl Solution {
    pub fn max_length(arr: Vec<i32>, limit: i32) -> i32 {
        let mut arr = arr;
        arr.sort_unstable();
        let mut sum = 0;
        let mut count = 0;

        for &num in &arr {
            if sum + num <= limit {
                sum += num;
                count += 1;
            } else {
                break;
            }
        }

        count
    }
}