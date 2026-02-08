impl Solution {
    pub fn find_kth_positive(arr: Vec<i32>, k: i32) -> i32 {
        let mut missing_count = 0;
        let mut arr_idx = 0;
        let mut current_num = 1;

        loop {
            if arr_idx < arr.len() && arr[arr_idx] == current_num {
                arr_idx += 1;
            } else {
                missing_count += 1;
                if missing_count == k {
                    return current_num;
                }
            }
            current_num += 1;
        }
    }
}