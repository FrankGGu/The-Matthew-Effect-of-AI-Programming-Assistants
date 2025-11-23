impl Solution {
    pub fn duplicate_zeros(arr: &mut Vec<i32>) {
        let mut i = 0;
        let n = arr.len();
        while i < n {
            if arr[i] == 0 {
                arr.insert(i, 0);
                arr.pop();
                i += 2;
            } else {
                i += 1;
            }
        }
    }
}