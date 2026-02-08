impl Solution {
    pub fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Solution::gcd(b, a % b)
        }
    }

    pub fn number_of_different_subsequences_gcds(nums: Vec<i32>) -> i32 {
        let max_val = *nums.iter().max().unwrap() as usize;
        let mut present = vec![false; max_val + 1];
        for &num in &nums {
            present[num as usize] = true;
        }

        let mut count = 0;
        for i in 1..=max_val {
            let mut current_gcd = 0;
            for j in (1..=(max_val / i)).map(|x| x * i) {
                if present[j] {
                    if current_gcd == 0 {
                        current_gcd = j as i32;
                    } else {
                        current_gcd = Solution::gcd(current_gcd, j as i32);
                    }
                }
            }

            if current_gcd == i as i32 {
                count += 1;
            }
        }

        count
    }
}