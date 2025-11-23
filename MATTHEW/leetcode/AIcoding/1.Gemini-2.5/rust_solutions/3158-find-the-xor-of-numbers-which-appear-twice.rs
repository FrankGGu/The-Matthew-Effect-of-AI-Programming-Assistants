impl Solution {
    pub fn xor_all_nums_twice(nums: Vec<i32>) -> i32 {
        let mut counts = [0; 51];
        for &num in &nums {
            counts[num as usize] += 1;
        }

        let mut xor_sum = 0;
        for i in 1..=50 {
            if counts[i] == 2 {
                xor_sum ^= i as i32;
            }
        }
        xor_sum
    }
}