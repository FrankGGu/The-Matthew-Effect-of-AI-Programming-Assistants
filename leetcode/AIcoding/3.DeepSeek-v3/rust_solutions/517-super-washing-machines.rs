impl Solution {
    pub fn find_min_moves(machines: Vec<i32>) -> i32 {
        let total: i32 = machines.iter().sum();
        let n = machines.len() as i32;
        if total % n != 0 {
            return -1;
        }
        let avg = total / n;
        let mut res = 0;
        let mut balance = 0;
        for &num in machines.iter() {
            balance += num - avg;
            res = res.max((balance.abs()).max(num - avg));
        }
        res
    }
}