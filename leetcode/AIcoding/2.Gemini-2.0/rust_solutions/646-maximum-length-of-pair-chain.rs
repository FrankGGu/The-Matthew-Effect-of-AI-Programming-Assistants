impl Solution {
    pub fn find_longest_chain(pairs: Vec<Vec<i32>>) -> i32 {
        let mut pairs = pairs;
        pairs.sort_by(|a, b| a[1].cmp(&b[1]));
        let mut curr = i32::min_value();
        let mut ans = 0;
        for pair in pairs {
            if pair[0] > curr {
                curr = pair[1];
                ans += 1;
            }
        }
        ans
    }
}