pub fn minimum_sum_of_triplets(arr: Vec<i32>) -> i32 {
    let n = arr.len();
    let mut min_sum = i32::MAX;

    for i in 0..n {
        for j in (i + 1)..n {
            for k in (j + 1)..n {
                if arr[i] < arr[j] && arr[j] > arr[k] {
                    let sum = arr[i] + arr[j] + arr[k];
                    min_sum = min_sum.min(sum);
                }
            }
        }
    }

    if min_sum == i32::MAX { -1 } else { min_sum }
}