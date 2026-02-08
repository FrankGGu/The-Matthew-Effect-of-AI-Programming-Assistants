pub fn get_last_moment(n: i32, left: Vec<i32>, right: Vec<i32>) -> i32 {
    let max_left = left.iter().copied().max().unwrap_or(0);
    let max_right = right.iter().copied().map(|x| n - x).max().unwrap_or(0);
    max_left.max(max_right)
}