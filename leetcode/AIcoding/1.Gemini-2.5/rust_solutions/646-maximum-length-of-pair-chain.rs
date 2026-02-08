impl Solution {
    pub fn find_longest_chain(mut pairs: Vec<Vec<i32>>) -> i32 {
        if pairs.is_empty() {
            return 0;
        }

        pairs.sort_by(|a, b| a[1].cmp(&b[1]).then_with(|| a[0].cmp(&b[0])));

        let mut count = 0;
        let mut prev_end = i32::MIN; 

        for pair in pairs {
            let start = pair[0];
            let end = pair[1];

            if start > prev_end {
                count += 1;
                prev_end = end;
            }
        }

        count
    }
}