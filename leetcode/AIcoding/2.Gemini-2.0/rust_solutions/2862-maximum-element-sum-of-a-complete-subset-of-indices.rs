impl Solution {
    pub fn maximum_sum(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut ans = 0;
        for i in 1..=n {
            let mut sum = 0;
            let mut j = 1;
            while j * j <= i {
                if i % j == 0 {
                    sum += nums[i - 1] as i64;
                    if j * j != i && i / j <= n {
                        sum += nums[i - 1] as i64;
                    }
                }
                j += 1;
            }

            let mut sum2 = 0;
            let mut k = 1;
            while k * k <= i {
                if i % k == 0 {
                    sum2 += nums[i - 1] as i64;
                    if k * k != i && i / k != k{
                        sum2 -= nums[i-1] as i64;
                    }
                }
                k+=1;
            }

            let mut sum3 = 0;
            for l in 1..=(i as f64).sqrt() as i32 {
                if i % (l as usize) == 0 {
                    sum3 += nums[i-1] as i64;
                    if (l*l) as usize != i {
                        sum3 += nums[i-1] as i64;
                    }
                }
            }
            let mut sum4 = 0;
            for l in 1..=((i as f64).sqrt() as i32).floor() as i32{
                if i % (l as usize) == 0 {
                    sum4 += nums[i-1] as i64;
                    if (l*l) as usize != i {
                        sum4 += nums[i-1] as i64;
                    }
                }
            }

            let mut curr_sum = 0;
            let mut d = 1;
            while d * d <= i {
                if i % d == 0 {
                    curr_sum += nums[i - 1] as i64;
                    if d * d != i {
                        curr_sum += nums[i - 1] as i64;
                    }
                }
                d += 1;
            }
            ans = ans.max(curr_sum);
        }
        ans
    }
}