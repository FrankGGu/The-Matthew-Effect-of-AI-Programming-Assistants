impl Solution {
    pub fn number_of_ways(corridor: String) -> i32 {
        let mut seat_indices: Vec<usize> = Vec::new();
        for (i, c) in corridor.chars().enumerate() {
            if c == 'S' {
                seat_indices.push(i);
            }
        }

        let k = seat_indices.len();
        let modulo: i64 = 1_000_000_007;

        if k == 0 || k % 2 != 0 {
            return 0;
        }

        let mut ans: i64 = 1;

        // Iterate through the gaps between pairs of seats.
        // We need to consider gaps between s_1 and s_2, s_3 and s_4, ..., s_{k-3} and s_{k-2}.
        // These correspond to seat_indices[i] and seat_indices[i+1] where i is 1, 3, ..., k-3.
        for i in (1..=k - 3).step_by(2) {
            let gap = (seat_indices[i + 1] - seat_indices[i]) as i64;
            ans = (ans * gap) % modulo;
        }

        ans as i32
    }
}