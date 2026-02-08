trait Iterator {
    fn next(&mut self) -> Option<i32>;
}

struct PeekingIterator<I: Iterator> {
    iter: I,
    next_elem: Option<i32>,
}

impl<I: Iterator> PeekingIterator<I> {
    fn new(iter: I) -> Self {
        let mut peek_iter = PeekingIterator {
            iter,
            next_elem: None,
        };
        peek_iter.next_elem = peek_iter.iter.next();
        peek_iter
    }

    fn peek(&self) -> Option<i32> {
        self.next_elem
    }

    fn next(&mut self) -> Option<i32> {
        let result = self.next_elem;
        self.next_elem = self.iter.next();
        result
    }

    fn has_next(&self) -> bool {
        self.next_elem.is_some()
    }
}