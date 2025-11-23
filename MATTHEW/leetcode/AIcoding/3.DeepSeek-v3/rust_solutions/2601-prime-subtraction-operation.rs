impl Solution {
    pub fn prime_sub_operation(nums: Vec<i32>) -> bool {
        let max_num = *nums.iter().max().unwrap_or(&0);
        let mut sieve = vec![true; (max_num + 1) as usize];
        sieve[0] = false;
        sieve[1] = false;
        for i in 2..=(max_num as f64).sqrt() as i32 + 1 {
            if sieve[i as usize] {
                let mut j = i * i;
                while j <= max_num {
                    sieve[j as usize] = false;
                    j += i;
                }
            }
        }
        let mut prev = 0;
        for &num in nums.iter() {
            if num <= prev {
                return false;
            }
            let mut p = (num - prev - 1).max(0);
            while p > 0 && !sieve[p as usize] {
                p -= 1;
            }
            prev = num - p;
        }
        true
    }
}