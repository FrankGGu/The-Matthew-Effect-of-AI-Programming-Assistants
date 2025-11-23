impl Solution {
    pub fn min_changes(s: String) -> i32 {
        let n = s.len();
        let s = s.as_bytes();
        let mut ans = i32::MAX;

        for target in 0..26 {
            let mut changes = 0;
            for &c in s {
                let diff = (c - b'a') as i32 - target;
                if diff < 0 {
                    changes += -diff; // s[i] < target
                } else if diff > 0 {
                    changes += diff; // s[i] > target
                }
            }
            ans = ans.min(changes);
        }

        ans
    }
}