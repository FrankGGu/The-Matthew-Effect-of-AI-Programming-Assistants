impl Solution {
    pub fn prev_permutation(mut arr: &mut Vec<i32>) {
        let n = arr.len();
        if n <= 1 {
            return;
        }

        let mut i = n - 2;
        while i >= 0 && arr[i] <= arr[i + 1] {
            if i == 0 {
                arr.reverse();
                return;
            }
            i -= 1;
        }

        let mut j = n - 1;
        while arr[j] >= arr[i] {
            j -= 1;
        }

        arr.swap(i, j);
        arr[i + 1..].reverse();
    }
}