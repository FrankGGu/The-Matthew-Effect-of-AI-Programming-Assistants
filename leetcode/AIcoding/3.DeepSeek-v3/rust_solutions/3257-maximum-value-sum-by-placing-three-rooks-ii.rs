impl Solution {
    pub fn max_value_sum_ii(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut max1 = i64::MIN;
        let mut max2 = i64::MIN;
        let mut max3 = i64::MIN;
        let mut min1 = i64::MAX;
        let mut min2 = i64::MAX;
        let mut total = 0i64;

        for &num in &nums {
            let diff = (num + k) as i64 - num as i64;
            total += num as i64;
            if diff > max1 {
                max3 = max2;
                max2 = max1;
                max1 = diff;
            } else if diff > max2 {
                max3 = max2;
                max2 = diff;
            } else if diff > max3 {
                max3 = diff;
            }

            if diff < min1 {
                min2 = min1;
                min1 = diff;
            } else if diff < min2 {
                min2 = diff;
            }
        }

        let mut res = total;
        if n >= 3 {
            res = res.max(total + max1 + max2 + max3);
            res = res.max(total + max1 + max2 - min1);
            res = res.max(total + max1 - min1 - min2);
        }
        if n >= 2 {
            res = res.max(total + max1 + max2);
            res = res.max(total + max1 - min1);
        }
        if n >= 1 {
            res = res.max(total + max1);
        }
        res
    }
}