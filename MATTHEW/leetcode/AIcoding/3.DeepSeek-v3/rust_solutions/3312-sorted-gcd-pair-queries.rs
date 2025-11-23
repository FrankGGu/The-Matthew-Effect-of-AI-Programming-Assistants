impl Solution {
    pub fn solve(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let mut prefix = vec![0; n];
        let mut suffix = vec![0; n];

        prefix[0] = nums[0];
        for i in 1..n {
            prefix[i] = Self::gcd(prefix[i-1], nums[i]);
        }

        suffix[n-1] = nums[n-1];
        for i in (0..n-1).rev() {
            suffix[i] = Self::gcd(suffix[i+1], nums[i]);
        }

        let mut res = Vec::new();
        for q in queries {
            let x = q[0] as usize;
            let y = q[1] as usize;
            if x == 0 {
                res.push(suffix[y+1]);
            } else if y == n-1 {
                res.push(prefix[x-1]);
            } else {
                res.push(Self::gcd(prefix[x-1], suffix[y+1]));
            }
        }
        res
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}