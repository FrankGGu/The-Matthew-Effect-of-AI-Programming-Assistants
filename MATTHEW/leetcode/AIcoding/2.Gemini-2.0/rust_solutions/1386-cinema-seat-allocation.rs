use std::collections::HashSet;

impl Solution {
    pub fn max_number_of_families(n: i32, reserved_seats: Vec<Vec<i32>>) -> i32 {
        let mut reserved: std::collections::HashMap<i32, HashSet<i32>> = std::collections::HashMap::new();
        for seat in reserved_seats {
            let row = seat[0];
            let col = seat[1];
            reserved.entry(row).or_insert(HashSet::new()).insert(col);
        }

        let mut count = n * 2;
        for (row, seats) in reserved.iter() {
            let mut possible = 0;
            if !seats.contains(&2) && !seats.contains(&3) && !seats.contains(&4) && !seats.contains(&5) {
                possible += 1;
            }
            if !seats.contains(&6) && !seats.contains(&7) && !seats.contains(&8) && !seats.contains(&9) {
                possible += 1;
            }
            if possible == 0 {
                count -= 2;
            } else if possible == 1 {
                count -= 1;
            }

            if !seats.contains(&4) && !seats.contains(&5) && !seats.contains(&6) && !seats.contains(&7) && possible == 0 {
                count += 1;
            } else if !seats.contains(&4) && !seats.contains(&5) && !seats.contains(&6) && !seats.contains(&7) && possible == 1{
                // Do nothing
            } else if !seats.contains(&4) && !seats.contains(&5) && !seats.contains(&6) && !seats.contains(&7) && possible == 2{
                // Do nothing
            }
        }

        count
    }
}