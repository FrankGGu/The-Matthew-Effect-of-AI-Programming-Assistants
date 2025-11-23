struct Solution;

impl Solution {
    pub fn equal_distinct_characters(word1: String, word2: String) -> bool {
        let mut freq1 = [0; 26];
        for c in word1.bytes() {
            freq1[(c - b'a') as usize] += 1;
        }

        let mut freq2 = [0; 26];
        for c in word2.bytes() {
            freq2[(c - b'a') as usize] += 1;
        }

        for i in 0..26 { // Character index to take from word1 (c1)
            for j in 0..26 { // Character index to take from word2 (c2)
                // We must have at least one instance of c1 in word1
                // and at least one instance of c2 in word2 to perform the swap
                if freq1[i] == 0 || freq2[j] == 0 {
                    continue;
                }

                // Simulate the swap:
                // word1 loses char i, gains char j
                freq1[i] -= 1;
                freq1[j] += 1;
                // word2 loses char j, gains char i
                freq2[j] -= 1;
                freq2[i] += 1;

                // Calculate distinct counts after the simulated swap
                let mut distinct1 = 0;
                for k in 0..26 {
                    if freq1[k] > 0 {
                        distinct1 += 1;
                    }
                }

                let mut distinct2 = 0;
                for k in 0..26 {
                    if freq2[k] > 0 {
                        distinct2 += 1;
                    }
                }

                if distinct1 == distinct2 {
                    return true;
                }

                // Revert the swap for the next iteration
                // word1 gains char i, loses char j
                freq1[i] += 1;
                freq1[j] -= 1;
                // word2 gains char j, loses char i
                freq2[j] += 1;
                freq2[i] -= 1;
            }
        }

        false
    }
}