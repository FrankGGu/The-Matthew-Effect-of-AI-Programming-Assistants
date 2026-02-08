struct BlockManager {
    blocks: Vec<i32>,
}

impl BlockManager {
    fn new() -> Self {
        BlockManager { blocks: Vec::new() }
    }

    fn place_block(&mut self, width: i32, height: i32) -> i32 {
        let mut max_height = 0;
        for i in 0..width {
            if i < self.blocks.len() as i32 {
                if self.blocks[i as usize] > max_height {
                    max_height = self.blocks[i as usize];
                }
            }
        }
        let new_height = max_height + height;
        for i in 0..width {
            if i < self.blocks.len() as i32 {
                self.blocks[i as usize] = new_height;
            } else {
                self.blocks.push(new_height);
            }
        }
        new_height
    }
}

impl Solution {
    fn new() -> Self {
        Solution {}
    }

    fn block_placement_queries(operations: Vec<String>) -> Vec<i32> {
        let mut manager = BlockManager::new();
        let mut result = Vec::new();
        for op in operations {
            let parts: Vec<&str> = op.split_whitespace().collect();
            if parts[0] == "place" {
                let width = parts[1].parse().unwrap();
                let height = parts[2].parse().unwrap();
                let res = manager.place_block(width, height);
                result.push(res);
            }
        }
        result
    }
}