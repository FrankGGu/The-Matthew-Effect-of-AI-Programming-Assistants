struct CombinationIterator {
    characters: Vec<char>,
    indices: Vec<usize>,
    is_end: bool,
}

impl CombinationIterator {
    fn new(characters: String, combination_length: i32) -> Self {
        let characters: Vec<char> = characters.chars().collect();
        let combination_length = combination_length as usize;
        let mut indices = Vec::with_capacity(combination_length);
        for i in 0..combination_length {
            indices.push(i);
        }
        CombinationIterator {
            characters,
            indices,
            is_end: false,
        }
    }

    fn next(&mut self) -> String {
        if self.is_end {
            return String::new();
        }

        let mut result = String::new();
        for &i in &self.indices {
            result.push(self.characters[i]);
        }

        let mut i = self.indices.len() - 1;
        while i >= 0 && self.indices[i] == self.characters.len() - 1 - (self.indices.len() - 1 - i) {
            i -= 1;
        }

        if i < 0 {
            self.is_end = true;
        } else {
            self.indices[i] += 1;
            for j in i + 1..self.indices.len() {
                self.indices[j] = self.indices[j - 1] + 1;
            }
        }

        result
    }

    fn has_next(&self) -> bool {
        !self.is_end
    }
}