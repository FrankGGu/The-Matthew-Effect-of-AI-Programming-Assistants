impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut max_bits = 0;
        let mut operations = 0;

        for &num in &nums {
            let mut count = 0;
            let mut n = num;
            while n > 0 {
                if n % 2 == 1 {
                    operations += 1;
                }
                n /= 2;
                count += 1;
            }
            max_bits = max_bits.max(count);
        }

        operations + max_bits - 1
    }
}