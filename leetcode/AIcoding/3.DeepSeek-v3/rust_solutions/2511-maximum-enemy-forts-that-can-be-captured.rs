impl Solution {
    pub fn capture_forts(forts: Vec<i32>) -> i32 {
        let mut max_captured = 0;
        let n = forts.len();
        let mut i = 0;

        while i < n {
            if forts[i] == 1 {
                let mut j = i + 1;
                while j < n && forts[j] == 0 {
                    j += 1;
                }
                if j < n && forts[j] == -1 {
                    max_captured = max_captured.max(j - i - 1);
                }
                i = j;
            } else if forts[i] == -1 {
                let mut j = i + 1;
                while j < n && forts[j] == 0 {
                    j += 1;
                }
                if j < n && forts[j] == 1 {
                    max_captured = max_captured.max(j - i - 1);
                }
                i = j;
            } else {
                i += 1;
            }
        }

        max_captured as i32
    }
}