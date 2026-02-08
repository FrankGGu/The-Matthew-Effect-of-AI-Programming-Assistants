pub fn rearrange_bands(bands: Vec<i32>) -> Vec<i32> {
    let mut sorted_bands = bands.clone();
    sorted_bands.sort();
    let n = sorted_bands.len();
    let mut result = vec![0; n];

    let mid = (n + 1) / 2;
    let mut left = 0;
    let mut right = mid;

    for i in 0..n {
        if i % 2 == 0 {
            result[i] = sorted_bands[left];
            left += 1;
        } else {
            result[i] = sorted_bands[right];
            right += 1;
        }
    }

    result
}