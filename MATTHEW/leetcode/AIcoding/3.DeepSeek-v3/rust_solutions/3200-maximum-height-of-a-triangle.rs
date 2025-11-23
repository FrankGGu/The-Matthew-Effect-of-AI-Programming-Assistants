impl Solution {
    pub fn maximum_triangles(mut coins: Vec<i32>) -> i32 {
        coins.sort_unstable();
        let n = coins.len();
        let mut max_h = 0;
        for i in (0..n).rev() {
            if i + 1 < coins[i] as usize {
                continue;
            }
            max_h = max_h.max((i + 1) as i32);
        }
        max_h
    }
}