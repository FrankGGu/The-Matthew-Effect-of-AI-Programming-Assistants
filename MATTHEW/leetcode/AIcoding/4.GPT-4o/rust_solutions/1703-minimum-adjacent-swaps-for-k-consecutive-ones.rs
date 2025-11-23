pub fn min_swaps(data: Vec<i32>, k: i32) -> i32 {
    let ones_count = data.iter().filter(|&&x| x == 1).count();
    if ones_count < k as usize {
        return -1;
    }

    let mut current_ones = 0;
    for i in 0..k {
        if data[i as usize] == 1 {
            current_ones += 1;
        }
    }

    let mut min_swaps = k - current_ones;
    let mut left = 0;

    for right in k as usize..data.len() {
        if data[right] == 1 {
            current_ones += 1;
        }
        if data[left] == 1 {
            current_ones -= 1;
        }
        left += 1;

        min_swaps = min_swaps.min(k - current_ones);
    }

    min_swaps as i32
}