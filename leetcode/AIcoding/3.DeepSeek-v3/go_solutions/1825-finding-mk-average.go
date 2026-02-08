type MKAverage struct {
    m, k int
    nums []int
    sum int
    sorted []int
}

func Constructor(m int, k int) MKAverage {
    return MKAverage{
        m: m,
        k: k,
        nums: make([]int, 0, m),
        sorted: make([]int, 0, m),
    }
}

func (this *MKAverage) AddElement(num int) {
    if len(this.nums) == this.m {
        old := this.nums[0]
        this.nums = this.nums[1:]
        this.sum -= old

        idx := sort.SearchInts(this.sorted, old)
        this.sorted = append(this.sorted[:idx], this.sorted[idx+1:]...)
    }

    this.nums = append(this.nums, num)
    this.sum += num

    idx := sort.SearchInts(this.sorted, num)
    this.sorted = append(this.sorted, 0)
    copy(this.sorted[idx+1:], this.sorted[idx:])
    this.sorted[idx] = num
}

func (this *MKAverage) CalculateMKAverage() int {
    if len(this.nums) < this.m {
        return -1
    }

    sum := 0
    for i := this.k; i < len(this.sorted)-this.k; i++ {
        sum += this.sorted[i]
    }

    return sum / (this.m - 2*this.k)
}