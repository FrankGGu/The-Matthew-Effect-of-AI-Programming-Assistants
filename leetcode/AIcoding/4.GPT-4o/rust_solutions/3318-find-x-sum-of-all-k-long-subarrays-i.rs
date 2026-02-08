pub fn x_sum(arr: Vec<i32>, k: i32) -> i32 {
    let n = arr.len();
    let k = k as usize;
    let mut sum = 0;
    for i in 0..n {
        if i + k <= n {
            sum += arr[i..i + k].iter().sum::<i32>();
        }
    }
    sum
}