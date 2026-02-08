impl Solution {
    pub fn minimum_deletion(arr: Vec<i32>) -> i32 {
        let min_val = *arr.iter().min().unwrap();
        let max_val = *arr.iter().max().unwrap();
        let mut deletions = 0;
        for &num in &arr {
            if num == min_val || num == max_val {
                deletions += 1;
            }
        }
        deletions
    }
}