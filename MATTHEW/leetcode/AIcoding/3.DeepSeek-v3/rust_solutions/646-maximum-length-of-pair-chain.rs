impl Solution {
    pub fn find_longest_chain(mut pairs: Vec<Vec<i32>>) -> i32 {
        pairs.sort_by(|a, b| a[1].cmp(&b[1]));
        let mut count = 0;
        let mut prev_end = i32::MIN;
        for pair in pairs {
            if pair[0] > prev_end {
                count += 1;
                prev_end = pair[1];
            }
        }
        count
    }
}