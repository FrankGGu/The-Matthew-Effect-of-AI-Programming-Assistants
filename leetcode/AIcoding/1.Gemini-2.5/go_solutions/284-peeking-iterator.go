type PeekingIterator struct {
	iter    *Iterator
	nextVal int
	hasNxt  bool
}

func Constructor(iter *Iterator) *PeekingIterator {
	pi := &PeekingIterator{
		iter: iter,
	}
	if iter.hasNext() {
		pi.nextVal = iter.next()
		pi.hasNxt = true
	} else {
		pi.hasNxt = false
	}
	return pi
}

func (this *PeekingIterator) peek() int {
	return this.nextVal
}

func (this *PeekingIterator) next() int {
	currentNext := this.nextVal

	if this.iter.hasNext() {
		this.nextVal = this.iter.next()
		this.hasNxt = true
	} else {
		this.hasNxt = false
	}

	return currentNext
}

func (this *PeekingIterator) hasNext() bool {
	return this.hasNxt
}