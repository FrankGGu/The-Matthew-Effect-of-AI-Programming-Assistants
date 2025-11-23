impl Solution {
    pub fn sum_digit_difference(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut ans: i64 = 0;
        for i in 0..n {
            for j in i + 1..n {
                let num1 = nums[i];
                let num2 = nums[j];
                let mut min1 = 10;
                let mut max1 = -1;
                let mut temp = num1;
                while temp > 0 {
                    let digit = temp % 10;
                    min1 = min1.min(digit);
                    max1 = max1.max(digit);
                    temp /= 10;
                }
                let mut min2 = 10;
                let mut max2 = -1;
                let mut temp = num2;
                while temp > 0 {
                    let digit = temp % 10;
                    min2 = min2.min(digit);
                    max2 = max2.max(digit);
                    temp /= 10;
                }
                ans += (max1 - min1).abs() as i64 + (max2 - min2).abs() as i64;
            }
        }
        ans
    }
}