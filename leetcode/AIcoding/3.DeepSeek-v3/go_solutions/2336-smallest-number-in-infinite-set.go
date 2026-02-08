type SmallestInfiniteSet struct {
    addedBack map[int]bool
    minMissing int
}

func Constructor() SmallestInfiniteSet {
    return SmallestInfiniteSet{
        addedBack: make(map[int]bool),
        minMissing: 1,
    }
}

func (this *SmallestInfiniteSet) PopSmallest() int {
    if len(this.addedBack) > 0 {
        min := math.MaxInt32
        for num := range this.addedBack {
            if num < min {
                min = num
            }
        }
        delete(this.addedBack, min)
        return min
    }
    res := this.minMissing
    this.minMissing++
    return res
}

func (this *SmallestInfiniteSet) AddBack(num int) {
    if num < this.minMissing {
        this.addedBack[num] = true
    }
}