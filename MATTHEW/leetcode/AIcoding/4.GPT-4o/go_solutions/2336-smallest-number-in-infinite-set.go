type SmallestInfiniteSet struct {
    nums   map[int]bool
    smallest int
}

func Constructor() SmallestInfiniteSet {
    return SmallestInfiniteSet{
        nums:    make(map[int]bool),
        smallest: 1,
    }
}

func (this *SmallestInfiniteSet) PopSmallest() int {
    for {
        if !this.nums[this.smallest] {
            result := this.smallest
            this.smallest++
            return result
        }
        this.smallest++
    }
}

func (this *SmallestInfiniteSet) AddBack(num int) {
    if num < this.smallest {
        this.nums[num] = true
    }
}