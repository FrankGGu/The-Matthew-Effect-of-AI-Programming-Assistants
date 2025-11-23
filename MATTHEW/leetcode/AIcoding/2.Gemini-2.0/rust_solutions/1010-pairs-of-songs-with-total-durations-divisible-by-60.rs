impl Solution {
    pub fn num_pairs_divisible_by60(time: Vec<i32>) -> i32 {
        let mut remainders = vec![0; 60];
        let mut count = 0;
        for &t in &time {
            let remainder = t % 60;
            let complement = (60 - remainder) % 60;
            count += remainders[complement as usize];
            remainders[remainder as usize] += 1;
        }
        count
    }
}