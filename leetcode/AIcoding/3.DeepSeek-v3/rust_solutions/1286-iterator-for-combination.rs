struct CombinationIterator {
    chars: Vec<char>,
    indices: Vec<usize>,
    has_next: bool,
    len: usize,
}

impl CombinationIterator {
    fn new(characters: String, combination_length: i32) -> Self {
        let chars: Vec<char> = characters.chars().collect();
        let len = combination_length as usize;
        let mut indices: Vec<usize> = (0..len).collect();
        let has_next = chars.len() >= len;
        CombinationIterator {
            chars,
            indices,
            has_next,
            len,
        }
    }

    fn next(&mut self) -> String {
        let mut res = String::new();
        for &i in &self.indices {
            res.push(self.chars[i]);
        }
        self.has_next = false;
        for i in (0..self.len).rev() {
            if self.indices[i] != self.chars.len() - self.len + i {
                self.indices[i] += 1;
                for j in i + 1..self.len {
                    self.indices[j] = self.indices[j - 1] + 1;
                }
                self.has_next = true;
                break;
            }
        }
        res
    }

    fn has_next(&self) -> bool {
        self.has_next
    }
}