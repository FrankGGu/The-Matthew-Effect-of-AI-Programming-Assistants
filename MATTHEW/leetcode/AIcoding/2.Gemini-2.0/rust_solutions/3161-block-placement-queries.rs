impl Solution {
    pub fn can_place_blocks(n: i32, blocks: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let mut blocks = blocks;
        blocks.sort();
        let mut result = Vec::new();
        for query in queries {
            let k = query[0];
            let target = query[1];
            let mut placed = 0;
            let mut i = 0;
            while i < blocks.len() && placed < k {
                if blocks[i] <= target {
                    placed += 1;
                    i += 1;
                } else {
                    break;
                }
            }
            result.push(placed == k);
        }
        result
    }
}