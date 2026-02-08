impl Solution {
    pub fn nth_super_ugly_number(n: i32, primes: Vec<i32>) -> i32 {
        let n = n as usize;
        let k = primes.len();
        let mut ugly = vec![1; n];
        let mut idx = vec![0; k];
        let mut nums = vec![1; k];

        for i in 1..n {
            let mut min_val = i32::MAX;
            for j in 0..k {
                min_val = min_val.min(nums[j]);
            }
            ugly[i] = min_val;

            for j in 0..k {
                if nums[j] == min_val {
                    idx[j] += 1;
                    nums[j] = ugly[idx[j]] * primes[j];
                }
            }
        }

        ugly[n - 1]
    }
}