impl Solution {
    pub fn shift_distance(s: String, goal: String) -> i32 {
        if s.len() != goal.len() {
            return -1;
        }
        let n = s.len();
        let mut distance = n;

        for i in 0..n {
            if s[i..].to_string() + &s[..i] == goal {
                distance = distance.min(i as i32);
            }
        }

        if distance == n {
            return -1;
        }
        distance
    }
}