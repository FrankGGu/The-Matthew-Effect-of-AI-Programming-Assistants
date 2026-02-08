type FindSumPairs struct {
    nums1 []int
    nums2 []int
    freq2 map[int]int
}

func Constructor(nums1 []int, nums2 []int) FindSumPairs {
    freq2 := make(map[int]int)
    for _, num := range nums2 {
        freq2[num]++
    }
    return FindSumPairs{
        nums1: nums1,
        nums2: nums2,
        freq2: freq2,
    }
}

func (this *FindSumPairs) Add(index int, val int) {
    oldVal := this.nums2[index]
    this.freq2[oldVal]--
    if this.freq2[oldVal] == 0 {
        delete(this.freq2, oldVal)
    }

    this.nums2[index] += val
    newVal := this.nums2[index]
    this.freq2[newVal]++
}

func (this *FindSumPairs) Count(tot int) int {
    count := 0
    for _, num1 := range this.nums1 {
        complement := tot - num1
        if freq, ok := this.freq2[complement]; ok {
            count += freq
        }
    }
    return count
}