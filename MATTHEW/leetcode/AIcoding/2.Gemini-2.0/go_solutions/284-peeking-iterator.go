type PeekingIterator struct {
	iterator *Iterator
	next     *int
}

func Constructor(iter *Iterator) *PeekingIterator {
	return &PeekingIterator{iterator: iter}
}

func (this *PeekingIterator) hasNext() bool {
	if this.next != nil {
		return true
	}
	return this.iterator.hasNext()
}

func (this *PeekingIterator) next() int {
	if this.next != nil {
		val := *this.next
		this.next = nil
		return val
	}
	return this.iterator.next()
}

func (this *PeekingIterator) peek() int {
	if this.next != nil {
		return *this.next
	}
	if this.iterator.hasNext() {
		nextVal := this.iterator.next()
		this.next = &nextVal
		return *this.next
	}
	return 0
}