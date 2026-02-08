impl Solution {
    pub fn max_turbulence_size(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        if n < 2 {
            return n as i32;
        }

        let mut max_len = 1;
        let mut start = 0;
        for i in 1..n {
            if i == 1 {
                if arr[i] == arr[i - 1] {
                    start = 1;
                }

            } else {
                if (arr[i] > arr[i - 1] && arr[i - 1] < arr[i - 2]) || (arr[i] < arr[i - 1] && arr[i - 1] > arr[i - 2]) {

                } else {
                    if arr[i] == arr[i-1]{
                        start = i+1;
                    } else {
                        start = i;
                    }
                }
            }

            if arr[i] == arr[i-1] {
                 start = i;
            }

            max_len = max_len.max((i - start + 1) as i32);
        }

        max_len
    }
}