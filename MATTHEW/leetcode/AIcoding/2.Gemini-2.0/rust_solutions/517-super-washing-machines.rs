impl Solution {
    pub fn find_min_moves(machines: Vec<i32>) -> i32 {
        let sum: i32 = machines.iter().sum();
        let n = machines.len() as i32;

        if sum % n != 0 {
            return -1;
        }

        let avg = sum / n;
        let mut ans = 0;
        let mut curr = 0;

        for &machine in &machines {
            curr += machine - avg;
            ans = ans.max(curr.abs()).max(machine - avg);
        }

        ans
    }
}