use std::collections::HashMap;

impl Solution {
    pub fn num_of_ways(nums: Vec<i32>) -> i32 {
        const MOD: i32 = 1_000_000_007;

        fn comb(n: usize, k: usize) -> i32 {
            if k > n { return 0; }
            let mut num = 1;
            let mut denom = 1;
            for i in 0..k {
                num = num * (n - i) as i32 % MOD;
                denom = denom * (i + 1) as i32 % MOD;
            }
            num * denom.mod_inverse(MOD) % MOD
        }

        let mut memo = HashMap::new();

        fn ways(nums: &[i32], memo: &mut HashMap<Vec<i32>, i32>) -> i32 {
            if nums.len() <= 2 { return 1; }
            if let Some(&result) = memo.get(nums) {
                return result;
            }

            let root = nums[0];
            let (left, right): (Vec<_>, Vec<_>) = nums[1..].iter().partition(|&&x| x < root);
            let l = left.len();
            let r = right.len();
            let result = (comb(l + r, l) * ways(&left, memo) % MOD * ways(&right, memo)) % MOD;
            memo.insert(nums.to_vec(), result);
            result
        }

        (ways(&nums, &mut memo) - 1 + MOD) % MOD
    }
}

trait ModInverse {
    fn mod_inverse(self, modulus: i32) -> i32;
}

impl ModInverse for i32 {
    fn mod_inverse(self, modulus: i32) -> i32 {
        let mut m0 = modulus;
        let mut y = 0;
        let mut x = 1;
        let mut a = self % modulus;
        if a < 0 { a += modulus; }

        while a > 1 {
            let q = a / m0;
            let t = m0;
            m0 = a % m0;
            a = t;
            let t = y;
            y = x - q * y;
            x = t;
        }

        if x < 0 { x += modulus; }
        x
    }
}