package main

type Solution struct {
    m      int
    n      int
    total  int
    used   map[int]bool
}

func Constructor(m int, n int) Solution {
    return Solution{
        m:      m,
        n:      n,
        total:  m * n,
        used:   make(map[int]bool),
    }
}

func (this *Solution) Flip() []int {
    for {
        r := rand.Intn(this.total)
        if !this.used[r] {
            this.used[r] = true
            return []int{r / this.n, r % this.n}
        }
    }
}

func (this *Solution) Reset() {
    this.used = make(map[int]bool)
}