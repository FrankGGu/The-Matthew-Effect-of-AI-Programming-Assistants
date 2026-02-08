impl Solution {
    pub fn find_kor(nums: Vec<i32>, k: i32) -> i32 {
        let mut k_or_result = 0;

        for i in 0..32 {
            let mut set_bit_count = 0;
            for &num in &nums {
                if (num >> i) & 1 == 1 {
                    set_bit_count += 1;
                }
            }
            if set_bit_count >= k {
                k_or_result |= (1 << i);
            }
        }
        k_or_result
    }
}