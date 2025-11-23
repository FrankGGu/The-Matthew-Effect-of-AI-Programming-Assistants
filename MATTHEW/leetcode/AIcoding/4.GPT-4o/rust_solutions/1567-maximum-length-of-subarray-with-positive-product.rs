impl Solution {
    pub fn get_max_len(nums: Vec<i32>) -> i32 {
        let mut max_len = 0;
        let mut positive_length = 0;
        let mut negative_length = 0;

        for &num in &nums {
            if num > 0 {
                positive_length += 1;
                negative_length += 1;
            } else if num < 0 {
                let temp = positive_length;
                positive_length = if negative_length > 0 { negative_length + 1 } else { 0 };
                negative_length = temp + 1;
            } else {
                positive_length = 0;
                negative_length = 0;
            }
            max_len = max_len.max(positive_length);
        }

        max_len
    }
}