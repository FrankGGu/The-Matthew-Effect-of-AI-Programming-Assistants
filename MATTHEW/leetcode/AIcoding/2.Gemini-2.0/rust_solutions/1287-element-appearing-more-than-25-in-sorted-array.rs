impl Solution {
    pub fn find_special_integer(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let quarter = n / 4;
        for i in 0..n - quarter {
            if arr[i] == arr[i + quarter] {
                return arr[i];
            }
        }
        0
    }
}