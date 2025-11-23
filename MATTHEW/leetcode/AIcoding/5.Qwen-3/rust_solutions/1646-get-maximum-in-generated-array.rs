struct Solution;

impl Solution {
    pub fn get_max_number(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        let mut arr = vec![0; n as usize];
        arr[0] = 0;
        if n >= 2 {
            arr[1] = 1;
        }
        for i in 2..n as usize {
            arr[i] = arr[i - 1] + arr[i - 2];
            if i % 2 == 0 {
                arr[i] = arr[i].max(arr[i / 2]);
            } else {
                arr[i] = arr[i].max(arr[(i - 1) / 2]);
            }
        }
        *arr.iter().max().unwrap()
    }
}