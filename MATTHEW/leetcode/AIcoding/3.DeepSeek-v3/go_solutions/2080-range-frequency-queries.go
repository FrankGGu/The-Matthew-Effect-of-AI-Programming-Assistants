type RangeFreqQuery struct {
    indices map[int][]int
}

func Constructor(arr []int) RangeFreqQuery {
    indices := make(map[int][]int)
    for i, num := range arr {
        indices[num] = append(indices[num], i)
    }
    return RangeFreqQuery{indices: indices}
}

func (this *RangeFreqQuery) Query(left int, right int, value int) int {
    idxs, ok := this.indices[value]
    if !ok {
        return 0
    }
    l := sort.Search(len(idxs), func(i int) bool { return idxs[i] >= left })
    r := sort.Search(len(idxs), func(i int) bool { return idxs[i] > right })
    return r - l
}