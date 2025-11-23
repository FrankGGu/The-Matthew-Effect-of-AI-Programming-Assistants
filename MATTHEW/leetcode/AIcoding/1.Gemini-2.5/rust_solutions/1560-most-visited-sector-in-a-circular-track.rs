impl Solution {
    pub fn most_visited(n: i32, rounds: Vec<i32>) -> Vec<i32> {
        let mut counts = vec![0; n as usize + 1]; // Use 1-based indexing

        for i in 0..rounds.len() - 1 {
            let start = rounds[i];
            let end = rounds[i+1];

            if start <= end {
                for j in start..=end {
                    counts[j as usize] += 1;
                }
            } else {
                // Wrap around the track
                for j in start..=n {
                    counts[j as usize] += 1;
                }
                for j in 1..=end {
                    counts[j as usize] += 1;
                }
            }
        }

        let mut max_count = 0;
        for i in 1..=n as usize {
            if counts[i] > max_count {
                max_count = counts[i];
            }
        }

        let mut result = Vec::new();
        for i in 1..=n as usize {
            if counts[i] == max_count {
                result.push(i as i32);
            }
        }

        result
    }
}