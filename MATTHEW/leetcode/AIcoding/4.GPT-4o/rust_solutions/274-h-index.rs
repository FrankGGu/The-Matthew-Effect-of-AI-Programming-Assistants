impl Solution {
    pub fn h_index(citations: Vec<i32>) -> i32 {
        let n = citations.len();
        let mut counts = vec![0; n + 1];

        for &c in &citations {
            if c >= n as i32 {
                counts[n] += 1;
            } else {
                counts[c as usize] += 1;
            }
        }

        let mut total = 0;
        for i in (0..=n).rev() {
            total += counts[i];
            if total >= i as i32 {
                return i as i32;
            }
        }

        0
    }
}