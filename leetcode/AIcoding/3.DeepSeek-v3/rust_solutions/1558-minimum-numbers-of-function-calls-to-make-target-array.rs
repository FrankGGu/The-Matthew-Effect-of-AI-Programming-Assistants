impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut operations = 0;
        let mut max_shift = 0;

        for &num in nums.iter() {
            let mut n = num;
            let mut shift = 0;

            while n > 0 {
                if n % 2 == 1 {
                    operations += 1;
                    n -= 1;
                } else {
                    shift += 1;
                    n /= 2;
                }
            }

            if shift > max_shift {
                max_shift = shift;
            }
        }

        operations + max_shift
    }
}