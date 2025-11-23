impl Solution {
    pub fn single_number(nums: Vec<i32>) -> i32 {
        let mut single_num = 0;
        for i in 0..32 {
            let mut bit_count = 0;
            for num in &nums {
                if ((num >> i) & 1) == 1 {
                    bit_count += 1;
                }
            }
            if (bit_count % 3) == 1 {
                single_num |= (1 << i);
            }
        }
        single_num
    }
}