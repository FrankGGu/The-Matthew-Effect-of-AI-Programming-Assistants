impl Solution {
    pub fn get_max_len(nums: Vec<i32>) -> i32 {
        let mut pos = 0;
        let mut neg = 0;
        let mut max_len = 0;

        for &num in &nums {
            if num > 0 {
                pos += 1;
                neg = if neg > 0 { neg + 1 } else { 0 };
            } else if num < 0 {
                let temp = pos;
                pos = if neg > 0 { neg + 1 } else { 0 };
                neg = if temp > 0 { temp + 1 } else { 1 };
            } else {
                pos = 0;
                neg = 0;
            }
            max_len = max_len.max(pos);
        }

        max_len as i32
    }
}