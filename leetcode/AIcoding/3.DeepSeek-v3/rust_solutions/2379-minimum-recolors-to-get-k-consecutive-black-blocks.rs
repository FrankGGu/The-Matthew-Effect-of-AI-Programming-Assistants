impl Solution {
    pub fn minimum_recolors(blocks: String, k: i32) -> i32 {
        let blocks: Vec<char> = blocks.chars().collect();
        let k = k as usize;
        let mut white_count = 0;
        for i in 0..k {
            if blocks[i] == 'W' {
                white_count += 1;
            }
        }
        let mut min_white = white_count;
        for i in k..blocks.len() {
            if blocks[i - k] == 'W' {
                white_count -= 1;
            }
            if blocks[i] == 'W' {
                white_count += 1;
            }
            min_white = min_white.min(white_count);
        }
        min_white
    }
}