impl Solution {
    pub fn balanced_string(s: String) -> i32 {
        let n = s.len();
        let target_count = n / 4;
        let mut count = [0; 4];
        let mut min_length = n as i32;

        for c in s.chars() {
            match c {
                'Q' => count[0] += 1,
                'W' => count[1] += 1,
                'E' => count[2] += 1,
                'R' => count[3] += 1,
                _ => {}
            }
        }

        let mut left = 0;
        for right in 0..n {
            let c = s.chars().nth(right).unwrap();
            match c {
                'Q' => count[0] -= 1,
                'W' => count[1] -= 1,
                'E' => count[2] -= 1,
                'R' => count[3] -= 1,
                _ => {}
            }

            while left <= right && count.iter().all(|&x| x <= target_count) {
                min_length = min_length.min((right - left + 1) as i32);
                let c_left = s.chars().nth(left).unwrap();
                match c_left {
                    'Q' => count[0] += 1,
                    'W' => count[1] += 1,
                    'E' => count[2] += 1,
                    'R' => count[3] += 1,
                    _ => {}
                }
                left += 1;
            }
        }

        min_length
    }
}