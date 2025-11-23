impl Solution {
    pub fn array_sign(nums: Vec<i32>) -> i32 {
        let mut neg_count = 0;
        for num in nums {
            if num == 0 {
                return 0;
            } else if num < 0 {
                neg_count += 1;
            }
        }

        if neg_count % 2 == 0 {
            1
        } else {
            -1
        }
    }
}