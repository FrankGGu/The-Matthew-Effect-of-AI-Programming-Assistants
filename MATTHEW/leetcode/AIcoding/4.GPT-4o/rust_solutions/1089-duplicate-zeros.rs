impl Solution {
    pub fn duplicate_zeros(arr: &mut Vec<i32>) {
        let mut zeros = 0;
        let n = arr.len();

        for &num in arr.iter() {
            if num == 0 {
                zeros += 1;
            }
        }

        let mut i = n as isize - 1;
        let mut j = (n + zeros) as isize - 1;

        while i >= 0 {
            if arr[i as usize] == 0 {
                if j < n as isize {
                    arr[j as usize] = 0;
                }
                j -= 1;
                if j < n as isize {
                    arr[j as usize] = 0;
                }
                j -= 1;
            } else {
                if j < n as isize {
                    arr[j as usize] = arr[i as usize];
                }
                j -= 1;
            }
            i -= 1;
        }
    }
}