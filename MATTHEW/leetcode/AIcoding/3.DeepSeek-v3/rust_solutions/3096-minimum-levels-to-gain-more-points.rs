impl Solution {
    pub fn minimum_levels(possible: Vec<i32>) -> i32 {
        let total: i32 = possible.iter().sum();
        let mut left = 0;
        for i in 0..possible.len() - 1 {
            left += possible[i];
            let right = total - left;
            if left > right {
                return (i + 1) as i32;
            }
        }
        -1
    }
}