type FindSumPairs struct {
    nums1 []int
    nums2 []int
    freq  map[int]int
}

func Constructor(nums1 []int, nums2 []int) FindSumPairs {
    freq := make(map[int]int)
    for _, num := range nums2 {
        freq[num]++
    }
    return FindSumPairs{
        nums1: nums1,
        nums2: nums2,
        freq:  freq,
    }
}

func (this *FindSumPairs) Add(index int, val int) {
    oldVal := this.nums2[index]
    this.freq[oldVal]--
    newVal := oldVal + val
    this.nums2[index] = newVal
    this.freq[newVal]++
}

func (this *FindSumPairs) Count(tot int) int {
    res := 0
    for _, num := range this.nums1 {
        res += this.freq[tot-num]
    }
    return res
}