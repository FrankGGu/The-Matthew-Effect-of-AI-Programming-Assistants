impl Solution {
    pub fn minimum_pushes(word: String) -> i32 {
        let mut freq = vec![0; 26];
        for c in word.chars() {
            freq[(c as u8 - b'a') as usize] += 1;
        }

        let mut non_zero_freqs: Vec<i32> = freq.into_iter().filter(|&f| f > 0).collect();
        non_zero_freqs.sort_unstable_by(|a, b| b.cmp(a));

        let mut total_pushes = 0;
        let mut push_cost = 1;
        let mut chars_assigned_at_current_cost_level = 0;

        for f in non_zero_freqs {
            total_pushes += f * push_cost;
            chars_assigned_at_current_cost_level += 1;

            if chars_assigned_at_current_cost_level == 8 {
                push_cost += 1;
                chars_assigned_at_current_cost_level = 0;
            }
        }

        total_pushes
    }
}