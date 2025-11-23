impl Solution {
    pub fn last_visited_integers(words: Vec<String>) -> Vec<i32> {
        let mut visited_numbers: Vec<i32> = Vec::new();
        let mut result: Vec<i32> = Vec::new();
        let mut prev_count: usize = 0;

        for word in words {
            if word == "prev" {
                prev_count += 1;
                if visited_numbers.len() >= prev_count {
                    result.push(visited_numbers[visited_numbers.len() - prev_count]);
                } else {
                    result.push(-1);
                }
            } else {
                prev_count = 0;
                visited_numbers.push(word.parse::<i32>().unwrap());
            }
        }

        result
    }
}