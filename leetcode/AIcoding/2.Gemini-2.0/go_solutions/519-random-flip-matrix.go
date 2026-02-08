import (
	"math/rand"
)

type Solution struct {
	m, n, size int
	mapping    map[int]int
}

func Constructor(m int, n int) Solution {
	return Solution{
		m:       m,
		n:       n,
		size:    m * n,
		mapping: make(map[int]int),
	}
}

func (this *Solution) Flip() []int {
	idx := rand.Intn(this.size)
	this.size--

	val, ok := this.mapping[idx]
	if !ok {
		val = idx
	}

	lastVal, ok := this.mapping[this.size]
	if !ok {
		lastVal = this.size
	}

	this.mapping[idx] = lastVal

	return []int{val / this.n, val % this.n}
}

func (this *Solution) Reset() {
	this.size = this.m * this.n
	this.mapping = make(map[int]int)
}