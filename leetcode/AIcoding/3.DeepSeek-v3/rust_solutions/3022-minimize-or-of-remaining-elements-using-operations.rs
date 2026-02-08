impl Solution {
    pub fn min_or_after_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut res = 0;
        for bit in (0..32).rev() {
            let mask = 1 << bit;
            let mut temp = res | mask;
            let mut count = 0;
            let mut current_or = 0;
            for &num in &nums {
                current_or |= num & !temp;
                if current_or == temp {
                    count += 1;
                    current_or = 0;
                }
            }
            if count >= k {
                res = temp;
            }
        }
        res
    }
}