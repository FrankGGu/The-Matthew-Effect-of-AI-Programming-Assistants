struct PeekingIterator<T> {
    iter: Box<dyn Iterator<Item = T>>,
    cache: Option<T>,
}

impl<T> PeekingIterator<T> {
    fn new(iter: Box<dyn Iterator<Item = T>>) -> Self {
        PeekingIterator { iter, cache: None }
    }

    fn next(&mut self) -> Option<T> {
        if let Some(val) = self.cache.take() {
            return Some(val);
        }
        self.iter.next()
    }

    fn peek(&self) -> Option<&T> {
        if self.cache.is_none() {
            self.cache = self.iter.next();
        }
        self.cache.as_ref()
    }

    fn has_next(&self) -> bool {
        self.cache.is_some() || self.iter.clone().next().is_some()
    }
}