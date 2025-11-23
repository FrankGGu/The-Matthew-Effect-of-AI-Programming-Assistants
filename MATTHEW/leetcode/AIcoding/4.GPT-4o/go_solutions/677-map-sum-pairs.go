type MapSum struct {
    m map[string]int
}

func Constructor() MapSum {
    return MapSum{m: make(map[string]int)}
}

func (this *MapSum) Insert(key string, val int) {
    this.m[key] = val
}

func (this *MapSum) Sum(prefix string) int {
    sum := 0
    for k, v := range this.m {
        if strings.HasPrefix(k, prefix) {
            sum += v
        }
    }
    return sum
}