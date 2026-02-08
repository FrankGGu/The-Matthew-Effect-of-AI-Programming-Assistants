impl Solution {
    pub fn three_sum_multi(arr: Vec<i32>, target: i32) -> i32 {
        let mut count = [0i64; 101];
        for &num in &arr {
            count[num as usize] += 1;
        }
        let mut res = 0i64;
        let modulo = 1_000_000_007;

        for i in 0..=100 {
            for j in i..=100 {
                let k = target - i - j;
                if k < j || k > 100 {
                    continue;
                }
                if count[i as usize] == 0 || count[j as usize] == 0 || count[k as usize] == 0 {
                    continue;
                }
                if i == j && j == k {
                    res += count[i as usize] * (count[i as usize] - 1) * (count[i as usize] - 2) / 6;
                } else if i == j {
                    res += count[i as usize] * (count[i as usize] - 1) / 2 * count[k as usize];
                } else if j == k {
                    res += count[j as usize] * (count[j as usize] - 1) / 2 * count[i as usize];
                } else {
                    res += count[i as usize] * count[j as usize] * count[k as usize];
                }
                res %= modulo;
            }
        }
        res as i32
    }
}