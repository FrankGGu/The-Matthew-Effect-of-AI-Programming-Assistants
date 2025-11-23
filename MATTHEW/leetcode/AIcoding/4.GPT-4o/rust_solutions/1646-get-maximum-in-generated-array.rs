impl Solution {
    pub fn get_maximum_generated(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        let mut arr = vec![0; (n + 1) as usize];
        arr[1] = 1;
        for i in 1..=(n / 2) {
            arr[2 * i as usize] = arr[i as usize];
            if 2 * i + 1 <= n {
                arr[2 * i as usize + 1] = arr[i as usize] + arr[i as usize + 1];
            }
        }
        *arr.iter().max().unwrap()
    }
}