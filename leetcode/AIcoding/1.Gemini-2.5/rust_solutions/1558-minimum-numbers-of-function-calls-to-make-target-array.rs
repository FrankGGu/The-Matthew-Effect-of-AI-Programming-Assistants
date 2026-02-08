impl Solution {
    pub fn min_operations(mut nums: Vec<i32>) -> i32 {
        let mut total_increments = 0;
        let mut max_doubles = 0;

        for num in nums.iter() {
            let mut current_num = *num;
            let mut current_doubles_for_this_num = 0;

            if current_num == 0 {
                continue;
            }

            while current_num > 0 {
                if current_num % 2 == 1 {
                    // If the number is odd, it must have been incremented at some point.
                    // In reverse, we decrement it. This counts as one 'increment' operation.
                    total_increments += 1;
                    current_num -= 1;
                } else {
                    // If the number is even, it could have been doubled.
                    // In reverse, we divide it by 2. This counts towards 'double all' operations.
                    current_num /= 2;
                    current_doubles_for_this_num += 1;
                }
            }
            // The total number of 'double all' operations is limited by the number
            // of times the largest element had to be doubled.
            max_doubles = max_doubles.max(current_doubles_for_this_num);
        }

        total_increments + max_doubles
    }
}