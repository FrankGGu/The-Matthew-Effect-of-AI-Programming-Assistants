use std::collections::HashSet;

impl Solution {
    pub fn max_number_of_families(n: i32, reserved_seats: Vec<Vec<i32>>) -> i32 {
        let mut reserved = HashSet::new();
        for seat in reserved_seats {
            reserved.insert((seat[0], seat[1]));
        }
        let mut result = 2 * n;
        let mut rows = HashSet::new();
        for &(row, col) in &reserved {
            if col >= 2 && col <= 9 {
                rows.insert(row);
            }
        }
        for row in rows {
            let mut count = 0;
            if !reserved.contains(&(row, 2)) && !reserved.contains(&(row, 3)) && !reserved.contains(&(row, 4)) && !reserved.contains(&(row, 5)) {
                count += 1;
            }
            if !reserved.contains(&(row, 6)) && !reserved.contains(&(row, 7)) && !reserved.contains(&(row, 8)) && !reserved.contains(&(row, 9)) {
                count += 1;
            }
            if count == 0 && !reserved.contains(&(row, 4)) && !reserved.contains(&(row, 5)) && !reserved.contains(&(row, 6)) && !reserved.contains(&(row, 7)) {
                count += 1;
            }
            result -= 2 - count;
        }
        result
    }
}