pub fn count_pairs_with_xor_in_range(arr: Vec<i32>, low: i32, high: i32) -> i32 {
    let mut count = 0;
    let n = arr.len();

    for i in 0..n {
        for j in i + 1..n {
            let xor = arr[i] ^ arr[j];
            if xor >= low && xor <= high {
                count += 1;
            }
        }
    }

    count
}