type FindSumPairs struct {
	nums1 []int
	nums2 []int
	count map[int]int
}

func Constructor(nums1 []int, nums2 []int) FindSumPairs {
	count := make(map[int]int)
	for _, num := range nums2 {
		count[num]++
	}
	return FindSumPairs{nums1: nums1, nums2: nums2, count: count}
}

func (this *FindSumPairs) Add(index int, val int) {
	this.count[this.nums2[index]]--
	this.nums2[index] += val
	this.count[this.nums2[index]]++
}

func (this *FindSumPairs) Count(tot int) int {
	res := 0
	for _, num := range this.nums1 {
		complement := tot - num
		res += this.count[complement]
	}
	return res
}