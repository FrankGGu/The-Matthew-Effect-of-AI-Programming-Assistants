pub fn cut_wood(lengths: Vec<i32>, k: i32) -> i32 {
    let mut left = 1;
    let mut right = *lengths.iter().max().unwrap();

    while left < right {
        let mid = left + (right - left) / 2;
        let total_pieces: i32 = lengths.iter().map(|&x| x / mid).sum();

        if total_pieces < k {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    left - 1
}