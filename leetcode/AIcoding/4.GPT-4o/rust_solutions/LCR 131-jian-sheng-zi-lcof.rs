pub fn min_time_to_cut(trees: Vec<i32>, target: i32) -> i32 {
    let mut left = 1;
    let mut right = *trees.iter().max().unwrap();
    let mut result = -1;

    while left <= right {
        let mid = left + (right - left) / 2;
        let mut sum = 0;

        for &tree in &trees {
            sum += tree / mid;
        }

        if sum >= target {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    result
}