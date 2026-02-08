impl Solution {
    pub fn maximum_number_of_string_pairs(words: Vec<String>) -> i32 {
        let mut count = 0;
        let n = words.len();
        for i in 0..n {
            for j in (i + 1)..n {
                let reversed_i: String = words[i].chars().rev().collect();
                if reversed_i == words[j] {
                    count += 1;
                }
            }
        }
        count
    }
}