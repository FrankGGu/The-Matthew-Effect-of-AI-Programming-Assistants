impl Solution {
    pub fn max_chunks_to_sorted(arr: Vec<i32>) -> i32 {
        let mut max_val = 0;
        let mut count = 0;
        for i in 0..arr.len() {
            max_val = max_val.max(arr[i] as i32);
            if max_val == i as i32 {
                count += 1;
            }
        }
        count
    }
}