struct PeekingIterator {
    iter: std::vec::IntoIter<i32>,
    peeked: Option<i32>,
}

impl PeekingIterator {
    fn new(iter: impl Iterator<Item = i32>) -> Self {
        let v: Vec<i32> = iter.collect();
        PeekingIterator {
            iter: v.into_iter(),
            peeked: None,
        }
    }

    fn peek(&mut self) -> i32 {
        if self.peeked.is_none() {
            self.peeked = self.iter.next();
        }
        self.peeked.unwrap()
    }

    fn next(&mut self) -> i32 {
        match self.peeked.take() {
            Some(val) => val,
            None => self.iter.next().unwrap(),
        }
    }

    fn has_next(&self) -> bool {
        self.peeked.is_some() || self.iter.len() > 0
    }
}