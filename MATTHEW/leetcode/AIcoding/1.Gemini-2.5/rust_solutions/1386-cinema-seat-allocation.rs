use std::collections::HashMap;

impl Solution {
    pub fn max_number_of_families(n: i32, reserved_seats: Vec<Vec<i32>>) -> i32 {
        let mut row_reservations: HashMap<i32, u16> = HashMap::new();

        for seat in reserved_seats {
            let row = seat[0];
            let col = seat[1];
            *row_reservations.entry(row).or_insert(0) |= (1 << col);
        }

        let mut total_families = 0;

        total_families += (n - row_reservations.len() as i32) * 2;

        const MASK_A: u16 = (1 << 2) | (1 << 3) | (1 << 4) | (1 << 5);
        const MASK_B: u16 = (1 << 4) | (1 << 5) | (1 << 6) | (1 << 7);
        const MASK_C: u16 = (1 << 6) | (1 << 7) | (1 << 8) | (1 << 9);

        for (_row_id, mask) in row_reservations {
            let mut families_in_this_row = 0;

            let can_seat_A = (mask & MASK_A) == 0;
            let can_seat_C = (mask & MASK_C) == 0;

            if can_seat_A && can_seat_C {
                families_in_this_row = 2;
            } else {
                let can_seat_B = (mask & MASK_B) == 0;
                if can_seat_A || can_seat_B || can_seat_C {
                    families_in_this_row = 1;
                }
            }
            total_families += families_in_this_row;
        }

        total_families
    }
}