import "math/rand"

type Solution struct {
    m    map[int]int
    upper int
}

func Constructor(n int, blacklist []int) Solution {
    m := make(map[int]int)
    bset := make(map[int]struct{})
    for _, b := range blacklist {
        bset[b] = struct{}{}
    }
    upper := n - len(blacklist)
    for _, b := range blacklist {
        if b < upper {
            for i := upper; i < n; i++ {
                if _, found := bset[i]; !found {
                    m[b] = i
                    break
                }
                upper++
            }
        }
    }
    return Solution{m: m, upper: upper}
}

func (this *Solution) Pick() int {
    x := rand.Intn(this.upper)
    if val, found := this.m[x]; found {
        return val
    }
    return x
}