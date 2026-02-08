impl Solution {
    pub fn number_of_good_subsets(nums: Vec<i32>) -> i32 {
        let primes: [i32; 10] = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
        let mut count: [i64; 31] = [0; 31];
        for &num in &nums {
            count[num as usize] += 1;
        }

        let mut dp: [i64; 1 << 10] = [0; 1 << 10];
        dp[0] = 1;

        for num in 2..=30 {
            if count[num] == 0 {
                continue;
            }

            let mut mask: usize = 0;
            let mut temp = num;
            let mut is_good = true;

            for i in 0..10 {
                if temp % primes[i] == 0 {
                    if temp % (primes[i] * primes[i]) == 0 {
                        is_good = false;
                        break;
                    }
                    mask |= 1 << i;
                    temp /= primes[i];
                }
            }

            if !is_good {
                continue;
            }

            for submask in 0..(1 << 10) {
                if (submask & mask) == 0 {
                    dp[submask | mask] = (dp[submask | mask] + dp[submask] * count[num]) % 1000000007;
                }
            }
        }

        let mut ans: i64 = 0;
        for i in 1..(1 << 10) {
            ans = (ans + dp[i]) % 1000000007;
        }

        let mut pow2: i64 = 1;
        for _ in 0..count[1] {
            pow2 = (pow2 * 2) % 1000000007;
        }

        ans = (ans * pow2) % 1000000007;

        ans as i32
    }
}