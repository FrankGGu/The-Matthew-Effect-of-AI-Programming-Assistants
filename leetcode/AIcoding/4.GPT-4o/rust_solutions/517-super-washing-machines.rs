impl Solution {
    pub fn find_min_moves(machines: Vec<i32>) -> i32 {
        let total = machines.iter().sum::<i32>();
        let n = machines.len() as i32;
        let mut max_moves = 0;

        if total % n != 0 {
            return -1;
        }

        let target = total / n;

        let mut current_sum = 0;
        for &m in &machines {
            current_sum += m - target;
            max_moves = max_moves.max(m - target).max(current_sum).max(0);
        }

        max_moves
    }
}