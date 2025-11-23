struct Solution;

impl Solution {
    pub fn partition_labels(s: String) -> Vec<i32> {
        let mut last_occurrence: [usize; 26] = [0; 26];

        for (i, c) in s.char_indices() {
            last_occurrence[(c as u8 - b'a') as usize] = i;
        }

        let mut result: Vec<i32> = Vec::new();
        let mut start = 0;
        let mut end = 0;

        for (i, c) in s.char_indices() {
            end = end.max(last_occurrence[(c as u8 - b'a') as usize]);

            if i == end {
                result.push((end - start + 1) as i32);
                start = i + 1;
            }
        }

        result
    }
}