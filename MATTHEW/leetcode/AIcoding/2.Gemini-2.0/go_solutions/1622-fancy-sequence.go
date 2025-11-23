type Fancy struct {
	seq []int
	add []int
	mul []int
	mod int
}

func Constructor() Fancy {
	return Fancy{
		seq: make([]int, 0),
		add: make([]int, 0),
		mul: make([]int, 0),
		mod: 1e9 + 7,
	}
}

func (this *Fancy) Append(val int) {
	this.seq = append(this.seq, val)
	this.add = append(this.add, 0)
	this.mul = append(this.mul, 1)
}

func (this *Fancy) AddAll(inc int) {
	if len(this.seq) == 0 {
		return
	}
	this.add[len(this.add)-1] = (this.add[len(this.add)-1] + inc) % this.mod
}

func (this *Fancy) MultAll(m int) {
	if len(this.seq) == 0 {
		return
	}
	this.mul[len(this.mul)-1] = (this.mul[len(this.mul)-1] * m) % this.mod
	this.add[len(this.add)-1] = (this.add[len(this.add)-1] * m) % this.mod
}

func (this *Fancy) GetIndex(idx int) int {
	if idx >= len(this.seq) {
		return -1
	}

	mul := 1
	add := 0

	for i := len(this.seq) - 1; i > idx; i-- {
		mul = (mul * this.mul[i]) % this.mod
		add = (add*this.mul[i] + this.add[i]) % this.mod
	}

	val := this.seq[idx]
	val = (val*mul + add) % this.mod
	if val < 0 {
		val += this.mod
	}
	return val
}