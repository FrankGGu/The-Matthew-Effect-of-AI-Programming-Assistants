impl Solution {
    pub fn prev_perm_opt1(arr: Vec<i32>) -> Vec<i32> {
        let mut arr = arr;
        let n = arr.len();
        for i in (0..n - 1).rev() {
            if arr[i] > arr[i + 1] {
                let mut j = n - 1;
                while j > i && arr[j] >= arr[i] {
                    j -= 1;
                }
                while j > 0 && arr[j] == arr[j - 1] {
                    j -= 1;
                }
                arr.swap(i, j);
                return arr;
            }
        }
        arr
    }
}