impl Solution {
    pub fn min_cost_to_make_rope_colorful(colors: String, needed_time: Vec<i32>) -> i32 {
        let colors_bytes = colors.as_bytes();
        let n = colors_bytes.len();
        let mut total_cost = 0;
        let mut i = 0;
        while i < n {
            let mut j = i;
            let mut max_time = 0;
            let mut group_cost = 0;
            while j < n && colors_bytes[i] == colors_bytes[j] {
                max_time = max_time.max(needed_time[j]);
                group_cost += needed_time[j];
                j += 1;
            }
            total_cost += group_cost - max_time;
            i = j;
        }
        total_cost
    }
}