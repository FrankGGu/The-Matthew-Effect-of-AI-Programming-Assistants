impl Solution {
    pub fn give_gem(gem: Vec<i32>, operations: Vec<Vec<i32>>) -> i32 {
        let mut gems = gem;
        for op in operations {
            let x = op[0] as usize;
            let y = op[1] as usize;
            let half = gems[x] / 2;
            gems[x] -= half;
            gems[y] += half;
        }
        let mut max_gem = gems[0];
        let mut min_gem = gems[0];
        for &g in &gems {
            max_gem = max_gem.max(g);
            min_gem = min_gem.min(g);
        }
        max_gem - min_gem
    }
}