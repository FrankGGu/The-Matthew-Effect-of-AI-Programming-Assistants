pub fn max_students(seats: Vec<Vec<char>>) -> i32 {
    let n = seats.len();
    let m = seats[0].len();
    let mut dp = vec![0; 1 << m];

    for row in seats.iter() {
        let mut new_dp = dp.clone();
        for mask in 0..(1 << m) {
            if !is_valid(mask, &row) {
                continue;
            }
            let count = mask.count_ones() as i32;
            new_dp[mask] = new_dp[mask].max(dp.iter().filter(|&&x| x > 0).max().unwrap_or(&0) + count);
        }
        dp = new_dp;
    }
    *dp.iter().max().unwrap_or(&0)
}

fn is_valid(mask: usize, row: &Vec<char>) -> bool {
    for i in 0..row.len() {
        if (mask >> i) & 1 == 1 {
            if row[i] == '#' {
                return false;
            }
            if i > 0 && (mask >> (i - 1)) & 1 == 1 {
                return false;
            }
            if i < row.len() - 1 && (mask >> (i + 1)) & 1 == 1 {
                return false;
            }
        }
    }
    true
}