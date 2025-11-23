impl Solution {
    pub fn duplicate_zeros(arr: &mut Vec<i32>) {
        let mut i = 0;
        let mut zeros = 0;
        let n = arr.len();

        while i < n - zeros {
            if arr[i] == 0 {
                zeros += 1;
            }
            i += 1;
        }

        let mut j = n - 1;
        let mut k = n - 1 - zeros;

        while j > k {
            if arr[k] == 0 {
                arr[j] = 0;
                j -= 1;
                arr[j] = 0;
            } else {
                arr[j] = arr[k];
            }
            j -= 1;
            k -= 1;
        }
    }
}