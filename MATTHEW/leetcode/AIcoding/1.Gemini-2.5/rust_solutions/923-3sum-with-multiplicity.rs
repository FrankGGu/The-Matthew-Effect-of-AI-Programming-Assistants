impl Solution {
    pub fn three_sum_multi(arr: Vec<i32>, target: i32) -> i32 {
        let mut counts = vec![0i64; 101];
        for &num in &arr {
            counts[num as usize] += 1;
        }

        let mut ans: i64 = 0;
        let modulo: i64 = 1_000_000_007;

        for x in 0..=100 {
            if counts[x] == 0 {
                continue;
            }
            for y in x..=100 {
                if counts[y] == 0 {
                    continue;
                }
                let z = target - x - y;

                if z < y || z > 100 {
                    continue;
                }
                if counts[z] == 0 {
                    continue;
                }

                if x == y && y == z {
                    ans = (ans + counts[x] * (counts[x] - 1) * (counts[x] - 2) / 6) % modulo;
                } else if x == y && y != z {
                    ans = (ans + counts[x] * (counts[x] - 1) / 2 * counts[z]) % modulo;
                } else if x != y && y == z {
                    ans = (ans + counts[x] * counts[y] * (counts[y] - 1) / 2) % modulo;
                } else { // x < y < z
                    ans = (ans + counts[x] * counts[y] * counts[z]) % modulo;
                }
            }
        }

        ans as i32
    }
}