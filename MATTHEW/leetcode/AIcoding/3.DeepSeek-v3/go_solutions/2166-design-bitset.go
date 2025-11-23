type Bitset struct {
    size int
    bits []int
    flipped bool
    count int
}

func Constructor(size int) Bitset {
    return Bitset{
        size: size,
        bits: make([]int, size),
        flipped: false,
        count: 0,
    }
}

func (this *Bitset) Fix(idx int) {
    if !this.flipped {
        if this.bits[idx] == 0 {
            this.bits[idx] = 1
            this.count++
        }
    } else {
        if this.bits[idx] == 1 {
            this.bits[idx] = 0
            this.count++
        }
    }
}

func (this *Bitset) Unfix(idx int) {
    if !this.flipped {
        if this.bits[idx] == 1 {
            this.bits[idx] = 0
            this.count--
        }
    } else {
        if this.bits[idx] == 0 {
            this.bits[idx] = 1
            this.count--
        }
    }
}

func (this *Bitset) Flip() {
    this.flipped = !this.flipped
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
    res := make([]byte, this.size)
    for i := 0; i < this.size; i++ {
        if (this.bits[i] == 1 && !this.flipped) || (this.bits[i] == 0 && this.flipped) {
            res[i] = '1'
        } else {
            res[i] = '0'
        }
    }
    return string(res)
}