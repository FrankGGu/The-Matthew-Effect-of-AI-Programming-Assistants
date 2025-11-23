impl Solution {
    pub fn count_elements(arr: Vec<i32>) -> i32 {
        let min_val = *arr.iter().min().unwrap();
        let max_val = *arr.iter().max().unwrap();
        let count = arr.len();
        if min_val == max_val {
            return 0;
        }
        count - arr.iter().filter(|&&x| x == min_val || x == max_val).count() as i32
    }
}