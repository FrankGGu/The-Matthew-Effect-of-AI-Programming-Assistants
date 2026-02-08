impl Solution {
    pub fn max_consecutive(bottom: i32, top: i32, special: Vec<i32>) -> i32 {
        let mut special = special;
        special.sort();
        let mut max_consecutive = std::cmp::max(special[0] - bottom, top - special[special.len() - 1]);

        for i in 0..special.len() - 1 {
            max_consecutive = std::cmp::max(max_consecutive, special[i+1] - special[i] - 1);
        }

        max_consecutive
    }
}