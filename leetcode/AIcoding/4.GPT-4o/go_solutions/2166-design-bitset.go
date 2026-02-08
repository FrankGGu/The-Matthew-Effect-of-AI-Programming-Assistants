type Bitset struct {
    bits []bool
    ones int
}

func Constructor(size int) Bitset {
    return Bitset{
        bits: make([]bool, size),
        ones: 0,
    }
}

func (this *Bitset) Fix(idx int) {
    if !this.bits[idx] {
        this.bits[idx] = true
        this.ones++
    }
}

func (this *Bitset) Unfix(idx int) {
    if this.bits[idx] {
        this.bits[idx] = false
        this.ones--
    }
}

func (this *Bitset) Flip() {
    for i := range this.bits {
        this.bits[i] = !this.bits[i]
    }
    this.ones = len(this.bits) - this.ones
}

func (this *Bitset) All() bool {
    return this.ones == len(this.bits)
}

func (this *Bitset) One() bool {
    return this.ones > 0
}

func (this *Bitset) Count() int {
    return this.ones
}

func (this *Bitset) ToString() string {
    res := ""
    for _, bit := range this.bits {
        if bit {
            res += "1"
        } else {
            res += "0"
        }
    }
    return res
}