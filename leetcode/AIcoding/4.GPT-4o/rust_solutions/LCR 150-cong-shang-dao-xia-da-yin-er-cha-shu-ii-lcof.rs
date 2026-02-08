impl Solution {
    pub fn num_of_ways(nums: Vec<i32>) -> i32 {
        const MOD: i32 = 1_000_000_007;
        fn dfs(nums: &[i32]) -> (i32, i32) {
            if nums.is_empty() {
                return (1, 1);
            }
            let root = nums[0];
            let (left, right): (Vec<i32>, Vec<i32>) =
                nums.iter().skip(1).partition(|&&x| x < root);
            let (left_ways, left_count) = dfs(&left);
            let (right_ways, right_count) = dfs(&right);
            let total_ways = left_ways * right_ways % MOD * binomial_coeff(left_count + right_count, left_count) % MOD;
            (total_ways, left_count + right_count + 1)
        }
        fn binomial_coeff(n: i32, k: i32) -> i32 {
            if k > n {
                return 0;
            }
            let mut num = 1;
            let mut denom = 1;
            for i in 0..k {
                num = num * (n - i) % MOD;
                denom = denom * (i + 1) % MOD;
            }
            num * denom.mod_inverse(MOD) % MOD
        }
        let (result, _) = dfs(&nums);
        (result - 1) % MOD
    }
}

trait ModInverse {
    fn mod_inverse(self, m: i32) -> i32;
}

impl ModInverse for i32 {
    fn mod_inverse(self, m: i32) -> i32 {
        let mut a = self;
        let mut m = m;
        let mut x0 = 0;
        let mut x1 = 1;
        if m == 1 {
            return 0;
        }
        while a > 1 {
            let q = a / m;
            let t = m;
            m = a % m;
            a = t;
            let t = x0;
            x0 = x1 - q * x0;
            x1 = t;
        }
        if x1 < 0 {
            x1 += m;
        }
        x1
    }
}