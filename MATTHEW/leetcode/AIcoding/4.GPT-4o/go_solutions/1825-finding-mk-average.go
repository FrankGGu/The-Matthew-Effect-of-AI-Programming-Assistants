type MKAverage struct {
    m      int
    k      int
    nums   []int
    sum    int
    window []int
    min    []int
    max    []int
}

func Constructor(m int, k int) MKAverage {
    return MKAverage{
        m:      m,
        k:      k,
        nums:   []int{},
        sum:    0,
        window: []int{},
        min:    []int{},
        max:    []int{},
    }
}

func (this *MKAverage) AddElement(num int) {
    this.nums = append(this.nums, num)
    this.window = append(this.window, num)
    if len(this.window) > this.m {
        removed := this.window[0]
        this.window = this.window[1:]
        this.sum -= removed
    }
    this.sum += num
    if len(this.window) == this.m {
        sort.Ints(this.window)
        this.min = this.window[:this.k]
        this.max = this.window[len(this.window)-this.k:]
        this.sum -= sum(this.min) + sum(this.max)
    }
}

func (this *MKAverage) CalculateMKAverage() int {
    if len(this.window) < this.m {
        return -1
    }
    return this.sum / (this.m - 2*this.k)
}

func sum(arr []int) int {
    total := 0
    for _, v := range arr {
        total += v
    }
    return total
}