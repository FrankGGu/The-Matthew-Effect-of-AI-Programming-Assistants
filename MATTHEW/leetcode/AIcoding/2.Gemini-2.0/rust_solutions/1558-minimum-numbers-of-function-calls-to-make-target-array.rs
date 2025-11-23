impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut ans = 0;
        let mut max_bits = 0;
        for &num in &nums {
            let mut bits = 0;
            let mut n = num;
            while n > 0 {
                bits += n & 1;
                n >>= 1;
            }
            ans += bits;

            let mut temp = num;
            let mut count = 0;
            while temp > 0 {
                temp >>= 1;
                count += 1;
            }
            max_bits = max_bits.max(count);
        }

        ans += max_bits - 1;

        ans
    }
}