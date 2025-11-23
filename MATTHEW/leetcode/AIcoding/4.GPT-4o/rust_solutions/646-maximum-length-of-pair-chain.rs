impl Solution {
    pub fn find_longest_chain(pairs: Vec<Vec<i32>>) -> i32 {
        let mut pairs = pairs;
        pairs.sort_by_key(|p| p[1]);
        let mut count = 0;
        let mut end = i32::MIN;

        for pair in pairs {
            if pair[0] > end {
                count += 1;
                end = pair[1];
            }
        }

        count
    }
}