struct Solution;

impl Solution {
    pub fn prison_after_n_days(mut cells: Vec<i32>, n: i32) -> Vec<i32> {
        let mut seen = std::collections::HashMap::new();
        let mut day = 0;
        let mut cells = cells;

        while day < n {
            if let Some(&cycle_day) = seen.get(&cells) {
                let cycle_length = day - cycle_day;
                let remaining_days = (n - day) % cycle_length;
                for _ in 0..remaining_days {
                    cells = Self::next_day(&cells);
                }
                break;
            }
            seen.insert(cells.clone(), day);
            cells = Self::next_day(&cells);
            day += 1;
        }

        cells
    }

    fn next_day(cells: &[i32]) -> Vec<i32> {
        let mut next = vec![0; cells.len()];
        for i in 1..cells.len() - 1 {
            if cells[i - 1] == cells[i + 1] {
                next[i] = 1;
            }
        }
        next
    }
}