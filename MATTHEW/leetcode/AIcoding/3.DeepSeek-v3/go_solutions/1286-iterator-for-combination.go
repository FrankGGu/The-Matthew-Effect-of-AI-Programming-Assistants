type CombinationIterator struct {
    combinations []string
    index        int
}

func Constructor(characters string, combinationLength int) CombinationIterator {
    var res []string
    var backtrack func(start int, path []byte)
    backtrack = func(start int, path []byte) {
        if len(path) == combinationLength {
            res = append(res, string(path))
            return
        }
        for i := start; i < len(characters); i++ {
            path = append(path, characters[i])
            backtrack(i+1, path)
            path = path[:len(path)-1]
        }
    }
    backtrack(0, []byte{})
    return CombinationIterator{combinations: res, index: 0}
}

func (this *CombinationIterator) Next() string {
    res := this.combinations[this.index]
    this.index++
    return res
}

func (this *CombinationIterator) HasNext() bool {
    return this.index < len(this.combinations)
}