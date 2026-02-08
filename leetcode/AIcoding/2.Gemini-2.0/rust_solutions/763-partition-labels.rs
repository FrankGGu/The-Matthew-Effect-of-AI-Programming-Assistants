impl Solution {
    pub fn partition_labels(s: String) -> Vec<i32> {
        let mut last_occurrence: [usize; 26] = [0; 26];
        for (i, c) in s.chars().enumerate() {
            last_occurrence[(c as u8 - b'a') as usize] = i;
        }

        let mut result: Vec<i32> = Vec::new();
        let mut start: usize = 0;
        let mut end: usize = 0;

        for (i, c) in s.chars().enumerate() {
            end = end.max(last_occurrence[(c as u8 - b'a') as usize]);
            if i == end {
                result.push((end - start + 1) as i32);
                start = end + 1;
            }
        }

        result
    }
}