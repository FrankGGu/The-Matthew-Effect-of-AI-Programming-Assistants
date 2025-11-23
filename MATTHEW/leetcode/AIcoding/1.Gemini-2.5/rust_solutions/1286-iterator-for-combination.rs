struct CombinationIterator {
    chars: Vec<char>,
    k: usize,
    indices: Vec<usize>,
    finished: bool,
}

impl CombinationIterator {
    fn new(characters: String, combination_length: i32) -> Self {
        let chars: Vec<char> = characters.chars().collect();
        let k = combination_length as usize;

        let indices: Vec<usize> = (0..k).collect();
        let finished = false;

        CombinationIterator {
            chars,
            k,
            indices,
            finished,
        }
    }

    fn has_next(&self) -> bool {
        !self.finished
    }

    fn next(&mut self) -> String {
        let current_combination: String = self.indices.iter().map(|&i| self.chars[i]).collect();

        let n = self.chars.len();
        let mut i = (self.k - 1) as isize;

        while i >= 0 {
            let current_idx_val = self.indices[i as usize];
            let max_val_for_current_pos = n - (self.k - (i as usize));

            if current_idx_val < max_val_for_current_pos {
                self.indices[i as usize] += 1;
                for j in (i as usize + 1)..self.k {
                    self.indices[j] = self.indices[j - 1] + 1;
                }
                break;
            }
            i -= 1;
        }

        if i < 0 {
            self.finished = true;
        }

        current_combination
    }
}