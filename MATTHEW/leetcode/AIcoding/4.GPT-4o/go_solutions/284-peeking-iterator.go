type PeekingIterator struct {
    iter *Iterator
    peeked bool
    peekedValue int
}

func Constructor(iter *Iterator) *PeekingIterator {
    return &PeekingIterator{iter: iter}
}

func (this *PeekingIterator) Peek() int {
    if !this.peeked {
        this.peekedValue = this.iter.Next()
        this.peeked = true
    }
    return this.peekedValue
}

func (this *PeekingIterator) Next() int {
    if this.peeked {
        this.peeked = false
        return this.peekedValue
    }
    return this.iter.Next()
}

func (this *PeekingIterator) HasNext() bool {
    return this.peeked || this.iter.HasNext()
}