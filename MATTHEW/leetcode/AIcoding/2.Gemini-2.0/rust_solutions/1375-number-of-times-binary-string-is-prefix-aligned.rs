impl Solution {
    pub fn num_times_all_blue(flips: Vec<i32>) -> i32 {
        let mut max_flip = 0;
        let mut count = 0;
        let mut blue_count = 0;

        for (i, &flip) in flips.iter().enumerate() {
            max_flip = max_flip.max(flip);
            blue_count += 1;
            if max_flip == (i + 1) as i32 {
                count += 1;
            }
        }

        count
    }
}