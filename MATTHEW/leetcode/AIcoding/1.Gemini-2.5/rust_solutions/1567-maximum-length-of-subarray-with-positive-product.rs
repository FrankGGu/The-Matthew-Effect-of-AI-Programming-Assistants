impl Solution {
    pub fn get_max_len(nums: Vec<i32>) -> i32 {
        let mut max_len = 0;
        let mut current_pos_len = 0; // Length of subarray ending here with a positive product
        let mut current_neg_len = 0; // Length of subarray ending here with a negative product

        for &num in nums.iter() {
            if num > 0 {
                current_pos_len += 1;
                if current_neg_len > 0 {
                    current_neg_len += 1;
                } else {
                    current_neg_len = 0; // A positive number cannot start a negative product subarray
                }
            } else if num < 0 {
                // To avoid using previous values that have already been updated,
                // we store them temporarily.
                let prev_pos_len = current_pos_len;
                let prev_neg_len = current_neg_len;

                // A negative number times a negative product makes a positive product.
                // If there was no previous negative product subarray (prev_neg_len == 0),
                // then a negative number cannot form a positive product subarray.
                if prev_neg_len > 0 {
                    current_pos_len = prev_neg_len + 1;
                } else {
                    current_pos_len = 0;
                }

                // A negative number times a positive product makes a negative product.
                // Even if prev_pos_len was 0, a single negative number forms a negative product subarray of length 1.
                current_neg_len = prev_pos_len + 1;
            } else { // num == 0
                // A zero resets both positive and negative product subarray lengths.
                current_pos_len = 0;
                current_neg_len = 0;
            }

            max_len = std::cmp::max(max_len, current_pos_len);
        }

        max_len
    }
}