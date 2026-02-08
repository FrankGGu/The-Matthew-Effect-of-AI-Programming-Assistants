impl Solution {
    pub fn give_gem(mut gem: Vec<i32>, operations: Vec<Vec<i32>>) -> i32 {
        for op in operations {
            let x = op[0] as usize;
            let y = op[1] as usize;
            let give = gem[x] / 2;
            gem[x] -= give;
            gem[y] += give;
        }
        let max = *gem.iter().max().unwrap();
        let min = *gem.iter().min().unwrap();
        max - min
    }
}