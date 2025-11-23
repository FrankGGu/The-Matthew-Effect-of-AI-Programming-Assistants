impl Solution {
    pub fn minimum_sum(arr: Vec<i32>) -> i32 {
        let mut arr = arr;
        arr.sort();
        arr[0] + arr[1] + arr[2] + arr[3]
    }
}