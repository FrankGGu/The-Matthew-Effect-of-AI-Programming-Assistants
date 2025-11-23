struct PeekingIterator<I> {
    iter: I,
    peeked_val: Option<I::Item>,
}

impl<I: Iterator> PeekingIterator<I> {
    fn new(mut iter: I) -> Self {
        let initial_peek = iter.next();
        PeekingIterator {
            iter,
            peeked_val: initial_peek,
        }
    }

    fn peek(&mut self) -> &I::Item {
        self.peeked_val.as_ref().unwrap()
    }

    fn next(&mut self) -> I::Item {
        let current_val = self.peeked_val.take().unwrap();
        self.peeked_val = self.iter.next();
        current_val
    }

    fn has_next(&self) -> bool {
        self.peeked_val.is_some()
    }
}