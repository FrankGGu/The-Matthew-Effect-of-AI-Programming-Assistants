impl Solution {
    pub fn count_colored_pieces(colors: String, needed_time: i32) -> i32 {
        let colors: Vec<char> = colors.chars().collect();
        let mut total_time = 0;
        let mut max_time = 0;
        let mut current_time = 0;

        for i in 0..colors.len() {
            if i > 0 && colors[i] == colors[i - 1] {
                current_time += needed_time;
                max_time = max_time.max(needed_time);
            } else {
                total_time += current_time - max_time;
                current_time = needed_time;
                max_time = needed_time;
            }
        }
        total_time + current_time - max_time
    }
}