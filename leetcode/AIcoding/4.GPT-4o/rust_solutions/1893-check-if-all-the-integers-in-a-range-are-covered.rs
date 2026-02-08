pub fn is_range_covering(ranges: Vec<Vec<i32>>, left: i32, right: i32) -> bool {
    let mut covered = vec![false; (right - left + 1) as usize];

    for range in ranges {
        let start = (range[0] - left) as usize;
        let end = (range[1] - left) as usize;
        for i in start..=end.min(covered.len() - 1) {
            covered[i] = true;
        }
    }

    covered.iter().all(|&x| x)
}