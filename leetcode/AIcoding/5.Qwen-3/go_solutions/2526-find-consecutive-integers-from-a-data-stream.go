package main

type DataStream struct {
	nums []int
	k    int
}

func Constructor(nums []int, k int) DataStream {
	return DataStream{nums: nums, k: k}
}

func (this *DataStream) consec(num int) bool {
	if len(this.nums) < this.k {
		return false
	}
	for i := 0; i <= len(this.nums)-this.k; i++ {
		allEqual := true
		for j := 0; j < this.k; j++ {
			if this.nums[i+j] != num {
				allEqual = false
				break
			}
		}
		if allEqual {
			return true
		}
	}
	return false
}