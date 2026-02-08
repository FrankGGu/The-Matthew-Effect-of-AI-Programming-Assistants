pub fn count_subarrays(arr: Vec<i32>, m: i32, k: i32) -> i32 {
    let n = arr.len();
    let mut count = 0;

    for i in 0..n {
        if arr[i] == m {
            let mut j = i;
            while j < n && arr[j] == m {
                j += 1;
            }
            let left = if i > 0 { i - (j - i) } else { 0 };
            let right = j - i; 
            count += right * (right + 1) / 2;
            i = j - 1;
        }
    }

    count
}