impl Solution {
    pub fn eliminate_maximum(dist: Vec<i32>, speed: Vec<i32>) -> i32 {
        let mut monsters: Vec<(i32, i32)> = dist.iter().zip(speed.iter()).map(|(&d, &s)| (d, s)).collect();
        monsters.sort_by_key(|&(d, s)| d / s + if d % s > 0 { 1 } else { 0 });
        let mut count = 0;
        for (i, &(d, s)) in monsters.iter().enumerate() {
            if count < d / s + if d % s > 0 { 1 } else { 0 } {
                count += 1;
            } else {
                return count;
            }
        }
        count
    }
}