use std::collections::HashMap;

impl Solution {
    pub fn most_frequent_prime(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut counts: HashMap<i32, i32> = HashMap::new();
        let mut max_freq = 0;
        let mut ans = -1;

        fn is_prime(num: i32) -> bool {
            if num <= 1 {
                return false;
            }
            if num <= 3 {
                return true;
            }
            if num % 2 == 0 || num % 3 == 0 {
                return false;
            }
            let mut i = 5;
            while i * i <= num {
                if num % i == 0 || num % (i + 2) == 0 {
                    return false;
                }
                i += 6;
            }
            true
        }

        for i in 0..m {
            for j in 0..n {
                for dx in -1..=1 {
                    for dy in -1..=1 {
                        if dx == 0 && dy == 0 {
                            continue;
                        }
                        let mut num = 0;
                        let mut r = i as i32;
                        let mut c = j as i32;
                        while r >= 0 && r < m as i32 && c >= 0 && c < n as i32 {
                            num = num * 10 + mat[r as usize][c as usize];
                            if num > 10 && is_prime(num) {
                                let count = counts.entry(num).or_insert(0);
                                *count += 1;
                                if *count > max_freq {
                                    max_freq = *count;
                                    ans = num;
                                } else if *count == max_freq && num > ans {
                                    ans = num;
                                }
                            }
                            r += dx;
                            c += dy;
                        }
                    }
                }
            }
        }

        ans
    }
}