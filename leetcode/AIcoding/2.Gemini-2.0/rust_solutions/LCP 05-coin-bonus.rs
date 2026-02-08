impl Solution {
    pub fn bonus(n: i32, m: i32, operations: Vec<Vec<i32>>) -> Vec<i32> {
        let mut diff = vec![0; (n + 1) as usize];
        for op in operations {
            let p = op[0] as usize;
            let q = op[1] as usize;
            let inc = op[2];

            diff[p - 1] += inc;
            if q < n as usize {
                diff[q] -= inc;
            }
        }

        let mut result = vec![0; n as usize];
        let mut current_bonus = 0;
        for i in 0..n as usize {
            current_bonus += diff[i];
            result[i] = current_bonus;
        }

        result
    }
}