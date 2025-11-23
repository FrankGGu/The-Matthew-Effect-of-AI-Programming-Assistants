struct Solution;

impl Solution {
    pub fn number_of_alternating_groups(s: Vec<i32>) -> i32 {
        let n = s.len();
        let mut count = 0;
        for i in 0..n {
            let prev = s[(i + n - 1) % n];
            let curr = s[i];
            let next = s[(i + 1) % n];
            if prev != curr && curr != next {
                count += 1;
            }
        }
        count
    }
}