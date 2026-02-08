pub fn max_turbulence_size(arr: Vec<i32>) -> i32 {
    let n = arr.len();
    if n < 2 { return n as i32; }

    let mut max_len = 1;
    let mut current_len = 1;

    for i in 1..n {
        if (arr[i] > arr[i - 1] && (i == 1 || arr[i - 1] <= arr[i - 2])) || 
            (arr[i] < arr[i - 1] && (i == 1 || arr[i - 1] >= arr[i - 2]))) {
            current_len += 1;
        } else {
            current_len = 2 * (arr[i] != arr[i - 1]) as i32 + 1;
        }
        max_len = max_len.max(current_len);
    }

    max_len
}