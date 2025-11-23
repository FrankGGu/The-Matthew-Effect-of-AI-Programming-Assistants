impl Solution {
    pub fn minimum_recolors(blocks: String, k: i32) -> i32 {
        let blocks = blocks.chars().collect::<Vec<_>>();
        let mut white_count = 0;
        let k = k as usize;

        for i in 0..k {
            if blocks[i] == 'W' {
                white_count += 1;
            }
        }

        let mut min_recolors = white_count;

        for i in k..blocks.len() {
            if blocks[i - k] == 'W' {
                white_count -= 1;
            }
            if blocks[i] == 'W' {
                white_count += 1;
            }
            min_recolors = min_recolors.min(white_count);
        }

        min_recolors
    }
}