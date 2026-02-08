impl Solution {
    pub fn count_different_subsequence_gcds(nums: Vec<i32>) -> i32 {
        let max_num = *nums.iter().max().unwrap();
        let mut count = 0;
        let mut present = vec![false; (max_num + 1) as usize];

        for &num in &nums {
            present[num as usize] = true;
        }

        for g in 1..=max_num {
            let mut current_gcd = 0;
            for multiple in (g..=max_num).step_by(g as usize) {
                if present[multiple as usize] {
                    current_gcd = gcd(current_gcd, multiple);
                }
            }
            if current_gcd == g {
                count += 1;
            }
        }

        count
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}