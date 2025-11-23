struct Solution;

impl Solution {
    pub fn find_celebrity(n: i32) -> i32 {
        if n <= 0 {
            return -1;
        }

        let mut candidate = 0;

        for i in 1..n {
            if knows(candidate, i) {
                candidate = i;
            }
        }

        for i in 0..n {
            if i == candidate {
                continue;
            }
            if knows(candidate, i) || !knows(i, candidate) {
                return -1;
            }
        }

        candidate
    }
}