impl Solution {
    pub fn find_closest(words: Vec<String>, word1: String, word2: String) -> i32 {
        let mut index1: Vec<usize> = Vec::new();
        let mut index2: Vec<usize> = Vec::new();
        for i in 0..words.len() {
            if words[i] == word1 {
                index1.push(i);
            }
            if words[i] == word2 {
                index2.push(i);
            }
        }
        let mut min_distance: i32 = i32::MAX;
        for i in &index1 {
            for j in &index2 {
                let distance = (i.abs_diff(*j)) as i32;
                if distance < min_distance {
                    min_distance = distance;
                }
            }
        }
        min_distance
    }
}