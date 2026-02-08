type Bitset struct {
	bits []bool
	size int
	count int
}

func Constructor(size int) Bitset {
	return Bitset{
		bits:  make([]bool, size),
		size:  size,
		count: 0,
	}
}

func (this *Bitset) Fix(idx int) {
	if !this.bits[idx] {
		this.bits[idx] = true
		this.count++
	}
}

func (this *Bitset) Unfix(idx int) {
	if this.bits[idx] {
		this.bits[idx] = false
		this.count--
	}
}

func (this *Bitset) Flip() {
	for i := 0; i < this.size; i++ {
		this.bits[i] = !this.bits[i]
	}
	this.count = this.size - this.count
}

func (this *Bitset) All() bool {
	return this.count == this.size
}

func (this *Bitset) One() bool {
	return this.count > 0
}

func (this *Bitset) Count() int {
	return this.count
}

func (this *Bitset) ToString() string {
	s := make([]byte, this.size)
	for i := 0; i < this.size; i++ {
		if this.bits[i] {
			s[i] = '1'
		} else {
			s[i] = '0'
		}
	}
	return string(s)
}