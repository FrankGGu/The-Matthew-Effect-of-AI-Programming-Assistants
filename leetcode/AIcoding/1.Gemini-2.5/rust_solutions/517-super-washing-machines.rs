impl Solution {
    pub fn find_min_moves(machines: Vec<i32>) -> i32 {
        let n = machines.len();

        let total_dresses: i32 = machines.iter().sum();

        if total_dresses % (n as i32) != 0 {
            return -1;
        }

        let avg = total_dresses / (n as i32);

        let mut max_moves = 0;
        let mut current_balance = 0;

        for &dresses in machines.iter() {
            max_moves = max_moves.max(dresses - avg);

            current_balance += dresses - avg;
            max_moves = max_moves.max(current_balance.abs());
        }

        max_moves
    }
}