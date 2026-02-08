impl Solution {
    pub fn maximum_removals(s: String, p: String, removable: Vec<i32>) -> i32 {
        let (s, p) = (s.as_bytes(), p.as_bytes());
        let (mut left, mut right) = (0, removable.len() as i32);

        while left < right {
            let mid = left + (right - left + 1) / 2;
            if Self::can_form(s, p, &removable[..mid as usize]) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }

        left
    }

    fn can_form(s: &[u8], p: &[u8], removable: &[i32]) -> bool {
        let mut removed = vec![false; s.len()];
        for &r in removable {
            removed[r as usize] = true;
        }

        let mut j = 0;
        for i in 0..s.len() {
            if !removed[i] && j < p.len() && s[i] == p[j] {
                j += 1;
            }
        }

        j == p.len()
    }
}