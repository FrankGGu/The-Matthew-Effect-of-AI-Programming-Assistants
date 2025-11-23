type Iterator struct {
    data []int
    pos  int
}

func (this *Iterator) hasNext() bool {
    return this.pos < len(this.data)
}

func (this *Iterator) next() int {
    val := this.data[this.pos]
    this.pos++
    return val
}

type PeekingIterator struct {
    iter *Iterator
    peeked *int
}

func Constructor(iter *Iterator) *PeekingIterator {
    return &PeekingIterator{iter, nil}
}

func (this *PeekingIterator) hasNext() bool {
    return this.peeked != nil || this.iter.hasNext()
}

func (this *PeekingIterator) next() int {
    if this.peeked != nil {
        val := *this.peeked
        this.peeked = nil
        return val
    }
    return this.iter.next()
}

func (this *PeekingIterator) peek() int {
    if this.peeked == nil {
        val := this.iter.next()
        this.peeked = &val
    }
    return *this.peeked
}