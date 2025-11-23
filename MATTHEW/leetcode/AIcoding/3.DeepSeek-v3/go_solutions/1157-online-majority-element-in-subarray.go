type MajorityChecker struct {
    arr []int
    pos map[int][]int
}

func Constructor(arr []int) MajorityChecker {
    pos := make(map[int][]int)
    for i, num := range arr {
        pos[num] = append(pos[num], i)
    }
    return MajorityChecker{arr, pos}
}

func (this *MajorityChecker) Query(left int, right int, threshold int) int {
    for i := 0; i < 20; i++ {
        idx := left + rand.Intn(right-left+1)
        num := this.arr[idx]
        l := sort.Search(len(this.pos[num]), func(i int) bool { return this.pos[num][i] >= left })
        r := sort.Search(len(this.pos[num]), func(i int) bool { return this.pos[num][i] > right })
        if r-l >= threshold {
            return num
        }
    }
    return -1
}