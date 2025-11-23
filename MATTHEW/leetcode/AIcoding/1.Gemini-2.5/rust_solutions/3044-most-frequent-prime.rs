use std::collections::HashMap;

struct Solution;

impl Solution {
    fn is_prime(n: i32) -> bool {
        if n < 2 {
            return false;
        }
        if n == 2 || n == 3 {
            return true;
        }
        if n % 2 == 0 || n % 3 == 0 {
            return false;
        }
        let mut i = 5;
        while i * i <= n {
            if n % i == 0 || n % (i + 2) == 0 {
                return false;
            }
            i += 6;
        }
        true
    }

    pub fn most_frequent_prime(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();

        let dr = [-1, -1, -1, 0, 0, 1, 1, 1];
        let dc = [-1, 0, 1, -1, 1, -1, 0, 1];

        let mut prime_counts: HashMap<i32, i32> = HashMap::new();

        for r in 0..rows {
            for c in 0..cols {
                for i in 0..8 { // 8 directions
                    let mut current_num = grid[r][c];
                    let mut nr = r as i32 + dr[i];
                    let mut nc = c as i32 + dc[i];

                    while nr >= 0 && nr < rows as i32 && nc >= 0 && nc < cols as i32 {
                        current_num = current_num * 10 + grid[nr as usize][nc as usize];

                        if current_num >= 10 && Self::is_prime(current_num) {
                            *prime_counts.entry(current_num).or_insert(0) += 1;
                        }

                        nr += dr[i];
                        nc += dc[i];
                    }
                }
            }
        }

        let mut max_freq = 0;
        let mut result = -1; 

        for (&prime, &freq) in prime_counts.iter() {
            if freq > max_freq {
                max_freq = freq;
                result = prime;
            } else if freq == max_freq {
                result = result.max(prime);
            }
        }

        result
    }
}