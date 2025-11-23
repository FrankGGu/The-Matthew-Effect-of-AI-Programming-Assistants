impl Solution {
    pub fn tribonacci(n: i32) -> i32 {
        match n {
            0 => 0,
            1 => 1,
            2 => 1,
            _ => {
                let mut trib = vec![0, 1, 1];
                for i in 3..=n {
                    let next = trib[(i - 1) as usize] + trib[(i - 2) as usize] + trib[(i - 3) as usize];
                    trib.push(next);
                }
                trib[n as usize]
            }
        }
    }
}