pub fn max_number_of_families(n: i32, reserved_seats: Vec<Vec<i32>>) -> i32 {
    use std::collections::HashSet;

    let mut reserved = HashSet::new();
    for seat in reserved_seats {
        reserved.insert((seat[0], seat[1]));
    }

    let mut total_families = 0;

    for row in 1..=n {
        let mut row_reserved = vec![false; 10];
        for col in 1..=9 {
            if reserved.contains(&(row, col)) {
                row_reserved[col] = true;
            }
        }

        let mut families = 0;
        if !row_reserved[2] && !row_reserved[3] && !row_reserved[4] && !row_reserved[5] {
            families += 1;
            row_reserved[2] = true;
            row_reserved[3] = true;
            row_reserved[4] = true;
            row_reserved[5] = true;
        }
        if !row_reserved[6] && !row_reserved[7] && !row_reserved[8] && !row_reserved[9] {
            families += 1;
            row_reserved[6] = true;
            row_reserved[7] = true;
            row_reserved[8] = true;
            row_reserved[9] = true;
        }
        if !row_reserved[4] && !row_reserved[5] && !row_reserved[6] && !row_reserved[7] {
            families += 1;
        }

        total_families += families;
    }

    total_families
}