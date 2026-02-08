package main

type Solution struct {
    m map[int]int
    n int
}

func Constructor(n int, blacklist []int) Solution {
    m := make(map[int]int)
    last := n - 1
    for _, b := range blacklist {
        if b < n {
            m[b] = 0
        }
    }
    for _, b := range blacklist {
        if b < n && b < last {
            for m[last] != 0 {
                last--
            }
            m[b] = last
            last--
        }
    }
    return Solution{m, n}
}

func (this *Solution) Pick() int {
    for {
        r := rand.Intn(this.n)
        if _, ok := this.m[r]; !ok {
            return r
        }
    }
}