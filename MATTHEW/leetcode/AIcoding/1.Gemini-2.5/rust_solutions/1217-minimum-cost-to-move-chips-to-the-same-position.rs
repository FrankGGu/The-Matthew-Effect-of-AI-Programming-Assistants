impl Solution {
    pub fn min_cost_to_move_chips(position: Vec<i32>) -> i32 {
        let mut even_count = 0;
        let mut odd_count = 0;

        for pos in position {
            if pos % 2 == 0 {
                even_count += 1;
            } else {
                odd_count += 1;
            }
        }

        even_count.min(odd_count)
    }
}