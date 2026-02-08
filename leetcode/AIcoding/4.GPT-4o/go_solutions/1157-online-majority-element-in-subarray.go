type MajorityChecker struct {
    arr []int
    indices map[int][]int
}

func Constructor(arr []int) MajorityChecker {
    indices := make(map[int][]int)
    for i, v := range arr {
        indices[v] = append(indices[v], i)
    }
    return MajorityChecker{arr: arr, indices: indices}
}

func (this *MajorityChecker) Query(left int, right int, threshold int) int {
    for _, v := range this.arr[left:right+1] {
        if count := this.countInRange(v, left, right); count >= threshold {
            return v
        }
    }
    return -1
}

func (this *MajorityChecker) countInRange(value, left, right int) int {
    indices := this.indices[value]
    l := sort.SearchInts(indices, left)
    r := sort.SearchInts(indices, right+1) // right+1 for inclusive
    return r - l
}