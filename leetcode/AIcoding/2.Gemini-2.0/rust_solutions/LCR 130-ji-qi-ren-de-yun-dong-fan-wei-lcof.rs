impl Solution {
    pub fn wardrobe_malfunction(n: i32, ranges: Vec<Vec<i32>>) -> i32 {
        let mut blocked = vec![false; n as usize];
        for range in &ranges {
            let start = std::cmp::max(0, range[0] - 1) as usize;
            let end = std::cmp::min(n, range[1]) as usize;
            for i in start..end {
                blocked[i] = true;
            }
        }

        let mut count = 0;
        for &b in &blocked {
            if !b {
                count += 1;
            }
        }

        count
    }
}