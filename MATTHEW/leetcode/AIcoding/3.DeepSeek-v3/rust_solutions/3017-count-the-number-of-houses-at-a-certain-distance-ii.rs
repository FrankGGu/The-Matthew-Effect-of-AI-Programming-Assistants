impl Solution {
    pub fn count_of_pairs(n: i32, x: i32, y: i32) -> Vec<i32> {
        let (n, x, y) = (n as usize, x as usize, y as usize);
        let (x, y) = (x.min(y), x.max(y));
        let mut res = vec![0; n];
        for i in 1..=n {
            for j in i + 1..=n {
                let d1 = j - i;
                let d2 = (x as i32 - i as i32).abs() as usize + 1 + (j as i32 - y as i32).abs() as usize;
                let d = d1.min(d2);
                if d <= n {
                    res[d - 1] += 2;
                }
            }
        }
        res
    }
}