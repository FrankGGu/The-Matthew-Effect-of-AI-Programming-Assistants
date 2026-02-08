pub fn has_adjacent_increasing_subarrays(arr: Vec<i32>) -> bool {
    let n = arr.len();
    if n < 3 {
        return false;
    }
    let mut prev = arr[0];
    let mut count = 0;

    for i in 1..n {
        if arr[i] > prev {
            count += 1;
            if count == 1 {
                continue;
            }
            if count > 1 {
                return true;
            }
        } else {
            count = 0;
        }
        prev = arr[i];
    }
    false
}