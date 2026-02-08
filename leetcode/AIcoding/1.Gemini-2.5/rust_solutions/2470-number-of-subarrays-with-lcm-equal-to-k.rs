impl Solution {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    fn lcm(a: i32, b: i32) -> i32 {
        if a == 0 || b == 0 {
            0
        } else {
            (a / Self::gcd(a, b)) * b
        }
    }

    pub fn subarray_lcm(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut count = 0;

        for i in 0..n {
            let mut current_lcm = 1;
            for j in i..n {
                let num_j = nums[j];

                if k % num_j != 0 {
                    break;
                }

                current_lcm = Self::lcm(current_lcm, num_j);

                if current_lcm == k {
                    count += 1;
                } else if current_lcm > k {
                    break;
                }
            }
        }
        count
    }
}