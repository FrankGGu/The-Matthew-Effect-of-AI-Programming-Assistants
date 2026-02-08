impl Solution {
    pub fn is_covered(ranges: Vec<Vec<i32>>, left: i32, right: i32) -> bool {
        let mut covered = vec![false; (right - left + 1) as usize];
        for range in &ranges {
            let start = range[0].max(left);
            let end = range[1].min(right);
            for i in start..=end {
                covered[(i - left) as usize] = true;
            }
        }
        covered.iter().all(|&x| x)
    }
}