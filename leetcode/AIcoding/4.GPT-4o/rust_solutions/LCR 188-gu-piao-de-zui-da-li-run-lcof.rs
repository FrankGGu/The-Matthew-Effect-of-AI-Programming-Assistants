impl Solution {
    pub fn min_cost_to_move_chips(position: Vec<i32>) -> i32 {
        let (even, odd) = position.iter().fold((0, 0), |(even, odd), &p| {
            if p % 2 == 0 {
                (even + 1, odd)
            } else {
                (even, odd + 1)
            }
        });
        odd.min(even)
    }
}