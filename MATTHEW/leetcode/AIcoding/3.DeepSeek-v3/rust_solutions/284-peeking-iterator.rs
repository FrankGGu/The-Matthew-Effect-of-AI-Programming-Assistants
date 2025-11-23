struct PeekingIterator<T> {
    iter: Box<dyn Iterator<Item = T>>,
    peeked: Option<Option<T>>,
}

impl<T: Clone> PeekingIterator<T> {
    fn new(iter: Box<dyn Iterator<Item = T>>) -> Self {
        PeekingIterator {
            iter,
            peeked: None,
        }
    }

    fn peek(&mut self) -> Option<&T> {
        if self.peeked.is_none() {
            self.peeked = Some(self.iter.next());
        }
        match &self.peeked {
            Some(Some(val)) => Some(val),
            _ => None,
        }
    }

    fn next(&mut self) -> Option<T> {
        match self.peeked.take() {
            Some(val) => val,
            None => self.iter.next(),
        }
    }

    fn has_next(&self) -> bool {
        self.peeked.is_some() || self.iter.size_hint().0 > 0
    }
}