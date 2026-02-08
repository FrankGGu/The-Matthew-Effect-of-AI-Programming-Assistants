impl Solution {
    pub fn count_different_subsequence_gcds(nums: Vec<i32>) -> i32 {
        let max_num = *nums.iter().max().unwrap_or(&0) as usize;
        let mut present = vec![false; max_num + 1];
        for &num in &nums {
            present[num as usize] = true;
        }
        let mut count = 0;
        for x in 1..=max_num {
            let mut current_gcd = 0;
            for multiple in (x..=max_num).step_by(x) {
                if present[multiple] {
                    current_gcd = gcd(current_gcd, multiple);
                    if current_gcd == x {
                        count += 1;
                        break;
                    }
                }
            }
        }
        count
    }
}

fn gcd(a: usize, b: usize) -> usize {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}