impl Solution {
    pub fn sum_distance(nums: Vec<i32>, s: String>, d: i32) -> i32 {
        let mut positions: Vec<i64> = nums.iter().map(|&x| x as i64).collect();
        let directions: Vec<char> = s.chars().collect();
        let n = positions.len();
        let d = d as i64;

        for i in 0..n {
            if directions[i] == 'L' {
                positions[i] -= d;
            } else {
                positions[i] += d;
            }
        }

        positions.sort();

        let mut prefix = 0i64;
        let mut res = 0i64;
        let modulo = 1_000_000_007;

        for i in 0..n {
            res = (res + positions[i] * i as i64 - prefix) % modulo;
            prefix = (prefix + positions[i]) % modulo;
        }

        res as i32
    }
}