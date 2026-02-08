pub fn magical_sequences(arr: Vec<i32>) -> i64 {
    let n = arr.len();
    let mut result = 0i64;
    let mut sum = 0i64;
    let mut product = 1i64;

    for i in 0..n {
        sum += arr[i] as i64;
        product *= arr[i] as i64;

        result += sum * product;
    }

    result
}