package main

type PeekingIterator struct {
	iter   *Iterator
	cache  int
	hasVal bool
}

func Constructor(iter *Iterator) *PeekingIterator {
	return &PeekingIterator{
		iter:   iter,
		cache:  0,
		hasVal: false,
	}
}

func (this *PeekingIterator) hasNext() bool {
	return this.hasVal || this.iter.hasNext()
}

func (this *PeekingIterator) next() int {
	if this.hasVal {
		this.hasVal = false
		return this.cache
	}
	return this.iter.next()
}

func (this *PeekingIterator) peek() int {
	if !this.hasVal {
		this.cache = this.iter.next()
		this.hasVal = true
	}
	return this.cache
}