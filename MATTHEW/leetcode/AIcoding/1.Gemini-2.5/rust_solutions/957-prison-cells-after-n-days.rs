use std::collections::HashMap;

impl Solution {
    pub fn prison_after_n_days(cells: Vec<i32>, n: i32) -> Vec<i32> {
        let mut current_state = cells;
        let mut history: HashMap<Vec<i32>, i32> = HashMap::new();
        let mut states_vec: Vec<Vec<i32>> = Vec::new();

        for day in 0..n {
            if history.contains_key(&current_state) {
                let prev_day = history[&current_state];
                let cycle_len = day - prev_day;
                let remaining_days = (n - day) % cycle_len;
                return states_vec[(prev_day + remaining_days) as usize].clone();
            }

            history.insert(current_state.clone(), day);
            states_vec.push(current_state.clone());

            let mut next_state = vec![0; 8];
            for i in 1..7 {
                if current_state[i - 1] == current_state[i + 1] {
                    next_state[i] = 1;
                } else {
                    next_state[i] = 0;
                }
            }
            current_state = next_state;
        }

        current_state
    }
}