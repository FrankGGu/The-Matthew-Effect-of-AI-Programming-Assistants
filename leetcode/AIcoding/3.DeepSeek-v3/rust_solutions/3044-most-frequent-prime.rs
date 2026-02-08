impl Solution {
    pub fn most_frequent_prime(mat: Vec<Vec<i32>>) -> i32 {
        use std::collections::HashMap;

        fn is_prime(n: i32) -> bool {
            if n <= 1 {
                return false;
            }
            if n == 2 {
                return true;
            }
            if n % 2 == 0 {
                return false;
            }
            let mut i = 3;
            while i * i <= n {
                if n % i == 0 {
                    return false;
                }
                i += 2;
            }
            true
        }

        let rows = mat.len();
        let cols = mat[0].len();
        let dirs = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),           (0, 1),
            (1, -1),  (1, 0),  (1, 1),
        ];
        let mut freq = HashMap::new();

        for i in 0..rows {
            for j in 0..cols {
                for &(di, dj) in dirs.iter() {
                    let mut x = i as i32;
                    let mut y = j as i32;
                    let mut num = 0;
                    while x >= 0 && x < rows as i32 && y >= 0 && y < cols as i32 {
                        num = num * 10 + mat[x as usize][y as usize];
                        if num > 10 && is_prime(num) {
                            *freq.entry(num).or_insert(0) += 1;
                        }
                        x += di;
                        y += dj;
                    }
                }
            }
        }

        if freq.is_empty() {
            return -1;
        }

        let max_freq = freq.values().max().unwrap();
        let candidates: Vec<_> = freq.iter()
            .filter(|&(_, &cnt)| cnt == *max_freq)
            .map(|(&num, _)| num)
            .collect();
        *candidates.iter().max().unwrap_or(&-1)
    }
}