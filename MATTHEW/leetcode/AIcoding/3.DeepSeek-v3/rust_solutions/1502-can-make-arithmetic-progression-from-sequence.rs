impl Solution {
    pub fn can_make_arithmetic_progression(arr: Vec<i32>) -> bool {
        let mut arr = arr;
        arr.sort();
        let diff = arr[1] - arr[0];
        for i in 2..arr.len() {
            if arr[i] - arr[i - 1] != diff {
                return false;
            }
        }
        true
    }
}