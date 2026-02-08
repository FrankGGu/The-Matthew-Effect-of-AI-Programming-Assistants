impl Solution {
    pub fn num_pairs_divisible_by60(time: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut remainders = [0; 60];

        for t in time {
            let remainder = (t % 60) as usize;
            if remainder == 0 {
                count += remainders[0];
            } else {
                count += remainders[60 - remainder];
            }
            remainders[remainder] += 1;
        }

        count
    }
}