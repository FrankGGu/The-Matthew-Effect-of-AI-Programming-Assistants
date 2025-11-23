import "math/rand"

type Solution struct {
    m, n, total int
    flipped     map[int]int
}

func Constructor(m int, n int) Solution {
    return Solution{m, n, m * n, make(map[int]int)}
}

func (this *Solution) Flip() []int {
    r := rand.Intn(this.total)
    this.total--
    x := r
    if v, ok := this.flipped[r]; ok {
        x = v
    }
    if v, ok := this.flipped[this.total]; ok {
        this.flipped[r] = v
    } else {
        this.flipped[r] = this.total
    }
    return []int{x / this.n, x % this.n}
}

func (this *Solution) Reset() {
    this.total = this.m * this.n
    this.flipped = make(map[int]int)
}