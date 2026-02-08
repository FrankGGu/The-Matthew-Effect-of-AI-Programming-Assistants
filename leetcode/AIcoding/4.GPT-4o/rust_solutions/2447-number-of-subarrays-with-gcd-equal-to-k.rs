impl Solution {
    pub fn subarray_gcd(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let n = nums.len();

        for i in 0..n {
            let mut current_gcd = 0;
            for j in i..n {
                current_gcd = gcd(current_gcd, nums[j]);
                if current_gcd == k {
                    count += 1;
                } else if current_gcd < k {
                    break;
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