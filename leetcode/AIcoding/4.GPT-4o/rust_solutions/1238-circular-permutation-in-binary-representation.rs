pub fn circular_permutation(n: i32, start: i32) -> Vec<i32> {
    let mut result = Vec::new();
    let total = 1 << n;
    for i in 0..total {
        result.push((i ^ (i >> 1)) + start);
    }
    result
}