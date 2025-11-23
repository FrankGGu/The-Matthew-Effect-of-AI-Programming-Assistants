impl Solution {
    pub fn minimum_recolors(blocks: String, k: i32) -> i32 {
        let n = blocks.len();
        let k = k as usize;

        let blocks_chars: Vec<char> = blocks.chars().collect();

        let mut current_whites = 0;
        for i in 0..k {
            if blocks_chars[i] == 'W' {
                current_whites += 1;
            }
        }

        let mut min_recolors = current_whites;

        for i in k..n {
            if blocks_chars[i - k] == 'W' {
                current_whites -= 1;
            }
            if blocks_chars[i] == 'W' {
                current_whites += 1;
            }
            min_recolors = min_recolors.min(current_whites);
        }

        min_recolors
    }
}