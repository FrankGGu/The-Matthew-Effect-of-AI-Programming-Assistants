struct CombinationIterator {
    characters: String,
    combination_length: usize,
    combinations: Vec<String>,
    current_index: usize,
}

impl CombinationIterator {
    fn new(characters: String, combination_length: i32) -> Self {
        let combination_length = combination_length as usize;
        let mut combinations = Vec::new();
        let mut current = Vec::new();

        fn generate_combinations(
            characters: &String,
            combination_length: usize,
            start: usize,
            current: &mut Vec<char>,
            combinations: &mut Vec<String>,
        ) {
            if current.len() == combination_length {
                combinations.push(current.iter().collect());
                return;
            }

            for i in start..characters.len() {
                current.push(characters.chars().nth(i).unwrap());
                generate_combinations(characters, combination_length, i + 1, current, combinations);
                current.pop();
            }
        }

        generate_combinations(&characters, combination_length, 0, &mut current, &mut combinations);

        CombinationIterator {
            characters,
            combination_length,
            combinations,
            current_index: 0,
        }
    }

    fn next(&mut self) -> String {
        let result = self.combinations[self.current_index].clone();
        self.current_index += 1;
        result
    }

    fn has_next(&self) -> bool {
        self.current_index < self.combinations.len()
    }
}