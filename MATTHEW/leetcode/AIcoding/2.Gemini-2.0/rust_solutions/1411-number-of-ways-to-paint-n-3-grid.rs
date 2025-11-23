impl Solution {
    pub fn num_of_ways(n: i32) -> i32 {
        let mut ab = 6;
        let mut ac = 6;

        for _ in 1..n {
            let next_ab = ac * 2 + ab * 3;
            let next_ac = ac * 2 + ab * 2;

            ab = next_ab % 1_000_000_007;
            ac = next_ac % 1_000_000_007;
        }

        (ab + ac) % 1_000_000_007
    }
}