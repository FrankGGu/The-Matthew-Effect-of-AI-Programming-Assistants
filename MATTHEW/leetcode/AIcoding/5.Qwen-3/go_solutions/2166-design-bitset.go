package main

type Bitset struct {
	data   []byte
	size   int
	ones   int
	flip   bool
}

func Constructor(size int) Bitset {
	return Bitset{
		data:   make([]byte, (size+7)/8),
		size:   size,
		ones:   0,
		flip:   false,
	}
}

func (this *Bitset) Set(idx int, val byte) {
	if this.flip {
		val = 1 - val
	}
	if val == 1 {
		if !this.get(idx) {
			this.ones++
		}
	} else {
		if this.get(idx) {
			this.ones--
		}
	}
	if val == 1 {
		this.data[idx/8] |= 1 << (idx % 8)
	} else {
		this.data[idx/8] &= ^(1 << (idx % 8))
	}
}

func (this *Bitset) Flip() {
	this.flip = !this.flip
	this.ones = this.size - this.ones
}

func (this *Bitset) Get(idx int) byte {
	if this.flip {
		return 1 - this.get(idx)
	}
	return this.get(idx)
}

func (this *Bitset) get(idx int) byte {
	return (this.data[idx/8] >> (idx % 8)) & 1
}

func (this *Bitset) Count() int {
	return this.ones
}