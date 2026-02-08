impl Solution {
    pub fn subarray_lcm(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let n = nums.len();

        for i in 0..n {
            let mut lcm = 1;
            for j in i..n {
                lcm = lcm * nums[j] / gcd(lcm, nums[j]);
                if lcm > k {
                    break;
                }
                if lcm == k {
                    count += 1;
                }
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