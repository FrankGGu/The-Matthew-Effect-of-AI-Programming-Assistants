const INF: i32 = 1_000_000_000; // A sufficiently large number

fn get_len_digits(count: i32) -> i32 {
    if count == 1 {
        0
    } else if count < 10 {
        1
    } else if count < 100 {
        2
    } else { // count == 100
        3
    }
}

struct Solution {
    memo: Vec<Vec<i32>>,
    s_bytes: Vec<u8>,
    n: usize,
}

impl Solution {
    fn solve(&mut self, idx: usize, k_rem: i32) -> i32 {
        // Base cases
        if k_rem < 0 {
            return INF; // Cannot delete more characters than allowed
        }
        if idx == self.n {
            return if k_rem == 0 { 0 } else { INF }; // Must delete exactly k_rem characters
        }

        // Check memoization table
        if self.memo[idx][k_rem as usize] != -1 {
            return self.memo[idx][k_rem as usize];
        }

        let mut res = INF;

        // Option 1: Delete s[idx]
        // We can always attempt to delete s[idx], even if k_rem is 0.
        // If k_rem becomes -1, the next call will return INF, correctly propagating invalid path.
        res = res.min(self.solve(idx + 1, k_rem - 1));

        // Option 2: Keep s[idx] and form a group starting with it
        let mut counts = [0; 26]; // Frequencies of characters in current window s[idx...j]
        let mut max_freq = 0; // Max frequency of any char in s[idx...j]

        for j in idx..self.n {
            let char_code = (self.s_bytes[j] - b'a') as usize;
            counts[char_code] += 1;
            max_freq = max_freq.max(counts[char_code]);

            // Calculate deletions needed for this segment s[idx...j]
            // We keep max_freq occurrences of the most frequent character.
            // The rest are deleted.
            let deletions_in_segment = (j - idx + 1) as i32 - max_freq;

            // If we have enough deletions remaining (k_rem) to cover deletions_in_segment
            if k_rem >= deletions_in_segment {
                let cost_of_segment = 1 + get_len_digits(max_freq);
                res = res.min(cost_of_segment + self.solve(j + 1, k_rem - deletions_in_segment));
            }
        }

        self.memo[idx][k_rem as usize] = res;
        res
    }
}

impl Solution {
    pub fn get_length_of_optimal_compression(s: String, k: i32) -> i32 {
        let n = s.len();
        let s_bytes = s.into_bytes();

        let mut solver = Solution {
            memo: vec![vec![-1; (k + 1) as usize]; n + 1],
            s_bytes,
            n,
        };

        solver.solve(0, k)
    }
}