impl Solution {
    pub fn count_different_subsequences_gcds(nums: Vec<i32>) -> i32 {
        let mut max_val = 0;
        for &num in &nums {
            if num > max_val {
                max_val = num;
            }
        }

        let mut seen = vec![false; (max_val + 1) as usize];
        for &num in &nums {
            seen[num as usize] = true;
        }

        let mut count = 0;
        for g in 1..=max_val {
            let mut current_gcd = 0;

            let mut multiple = g;
            while multiple <= max_val {
                if seen[multiple as usize] {
                    current_gcd = Self::gcd(current_gcd, multiple);

                    if current_gcd == g {
                        break; 
                    }
                }
                multiple += g;
            }

            if current_gcd == g {
                count += 1;
            }
        }

        count
    }

    fn gcd(mut a: i32, mut b: i32) -> i32 {
        while b != 0 {
            let temp = b;
            b = a % b;
            a = temp;
        }
        a
    }
}