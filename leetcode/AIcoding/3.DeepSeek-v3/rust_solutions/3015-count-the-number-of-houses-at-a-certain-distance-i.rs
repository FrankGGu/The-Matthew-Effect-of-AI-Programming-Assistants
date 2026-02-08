impl Solution {
    pub fn count_of_pairs(n: i32, x: i32, y: i32) -> Vec<i32> {
        let (x, y) = (x.min(y), x.max(y));
        let mut res = vec![0; n as usize];

        for i in 1..=n {
            for j in i + 1..=n {
                let d = (j - i).min((x - i).abs() + 1 + (j - y).abs());
                res[(d - 1) as usize] += 2;
            }
        }

        res
    }
}