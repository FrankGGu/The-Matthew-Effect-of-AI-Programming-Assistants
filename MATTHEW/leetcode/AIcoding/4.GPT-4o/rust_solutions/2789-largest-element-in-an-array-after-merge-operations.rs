pub fn find_the_maximum_num(arr: Vec<i32>, k: i32) -> i32 {
    let mut arr = arr;
    arr.sort_unstable();
    let n = arr.len();
    let mut max_num = arr[n - 1];
    for i in (0..n - 1).rev() {
        if k > 0 {
            max_num = max_num.max(arr[i] + k);
            k -= 1;
        }
    }
    max_num
}