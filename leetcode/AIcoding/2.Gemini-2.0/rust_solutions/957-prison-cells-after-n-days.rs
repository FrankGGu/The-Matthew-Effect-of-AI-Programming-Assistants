impl Solution {
    pub fn prison_after_n_days(cells: Vec<i32>, n: i32) -> Vec<i32> {
        let mut seen: std::collections::HashMap<Vec<i32>, i32> = std::collections::HashMap::new();
        let mut current_cells = cells;
        let mut current_day = 0;

        while current_day < n {
            if seen.contains_key(&current_cells) {
                let first_day = seen.get(&current_cells).unwrap();
                let period = current_day - first_day;
                let remaining_days = (n - current_day) % period;
                for _ in 0..remaining_days {
                    let mut next_cells = vec![0; current_cells.len()];
                    for i in 1..current_cells.len() - 1 {
                        if current_cells[i - 1] == current_cells[i + 1] {
                            next_cells[i] = 1;
                        }
                    }
                    current_cells = next_cells;
                }
                return current_cells;
            }

            seen.insert(current_cells.clone(), current_day);
            current_day += 1;

            let mut next_cells = vec![0; current_cells.len()];
            for i in 1..current_cells.len() - 1 {
                if current_cells[i - 1] == current_cells[i + 1] {
                    next_cells[i] = 1;
                }
            }
            current_cells = next_cells;
        }

        current_cells
    }
}