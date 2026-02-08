type MapSum struct {
    m map[string]int
    prefixSum map[string]int
}

func Constructor() MapSum {
    return MapSum{
        m: make(map[string]int),
        prefixSum: make(map[string]int),
    }
}

func (this *MapSum) Insert(key string, val int)  {
    diff := val - this.m[key]
    this.m[key] = val
    for i := 1; i <= len(key); i++ {
        this.prefixSum[key[:i]] += diff
    }
}

func (this *MapSum) Sum(prefix string) int {
    return this.prefixSum[prefix]
}