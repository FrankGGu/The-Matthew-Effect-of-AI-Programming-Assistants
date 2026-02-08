impl Solution {
    pub fn is_covered(ranges: Vec<Vec<i32>>, left: i32, right: i32) -> bool {
        let mut covered = vec![false; (right - left + 1) as usize];
        for range in ranges {
            let start = std::cmp::max(range[0], left);
            let end = std::cmp::min(range[1], right);
            for num in start..=end {
                covered[(num - left) as usize] = true;
            }
        }
        covered.iter().all(|&x| x)
    }
}