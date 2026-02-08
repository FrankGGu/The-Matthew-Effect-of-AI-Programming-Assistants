impl Solution {
    pub fn find_kth_positive(arr: Vec<i32>, k: i32) -> i32 {
        let mut missing_count = 0;
        let mut current = 1;
        let mut index = 0;

        while missing_count < k {
            if index < arr.len() && arr[index] == current {
                index += 1;
            } else {
                missing_count += 1;
            }
            current += 1;
        }

        current - 1
    }
}