type CombinationIterator struct {
    combinations []string
    index        int
}

func Constructor(n int, k int) CombinationIterator {
    res := []string{}
    var backtrack func(start int, path []int)
    backtrack = func(start int, path []int) {
        if len(path) == k {
            comb := ""
            for _, num := range path {
                comb += strconv.Itoa(num)
            }
            res = append(res, comb)
            return
        }
        for i := start; i <= n; i++ {
            backtrack(i+1, append(path, i))
        }
    }
    backtrack(1, []int{})
    return CombinationIterator{combinations: res, index: 0}
}

func (this *CombinationIterator) Next() string {
    result := this.combinations[this.index]
    this.index++
    return result
}

func (this *CombinationIterator) HasNext() bool {
    return this.index < len(this.combinations)
}