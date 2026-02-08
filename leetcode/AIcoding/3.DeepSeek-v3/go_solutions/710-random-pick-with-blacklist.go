import "math/rand"

type Solution struct {
    size int
    m    map[int]int
}

func Constructor(n int, blacklist []int) Solution {
    m := make(map[int]int)
    size := n - len(blacklist)
    for _, b := range blacklist {
        m[b] = -1
    }
    last := n - 1
    for _, b := range blacklist {
        if b >= size {
            continue
        }
        for {
            if _, ok := m[last]; !ok {
                break
            }
            last--
        }
        m[b] = last
        last--
    }
    return Solution{size: size, m: m}
}

func (this *Solution) Pick() int {
    r := rand.Intn(this.size)
    if v, ok := this.m[r]; ok {
        return v
    }
    return r
}