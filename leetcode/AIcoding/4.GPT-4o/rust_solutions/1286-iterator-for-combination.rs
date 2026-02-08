struct CombinationIterator {
    combinations: Vec<String>,
    index: usize,
}

impl CombinationIterator {
    fn new(characters: String, combination_length: i32) -> Self {
        let mut combinations = Vec::new();
        let chars: Vec<char> = characters.chars().collect();
        let len = chars.len();

        fn backtrack(combinations: &mut Vec<String>, chars: &Vec<char>, start: usize, path: &mut Vec<char>, combination_length: i32) {
            if path.len() as i32 == combination_length {
                combinations.push(path.iter().collect());
                return;
            }
            for i in start..chars.len() {
                path.push(chars[i]);
                backtrack(combinations, chars, i + 1, path, combination_length);
                path.pop();
            }
        }

        backtrack(&mut combinations, &chars, 0, &mut Vec::new(), combination_length);
        CombinationIterator { combinations, index: 0 }
    }

    fn next(&mut self) -> String {
        let result = self.combinations[self.index].clone();
        self.index += 1;
        result
    }

    fn has_next(&self) -> bool {
        self.index < self.combinations.len()
    }
}