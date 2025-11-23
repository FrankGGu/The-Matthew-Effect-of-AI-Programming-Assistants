import (
	"math/rand"
	"time"
)

type Solution struct {
	nums []int
	original []int
}

func Constructor(nums []int) Solution {
	original := make([]int, len(nums))
	copy(original, nums)
	return Solution{nums: nums, original: original}
}

func (this *Solution) Reset() []int {
	copy(this.nums, this.original)
	return this.nums
}

func (this *Solution) Shuffle() []int {
	rand.Seed(time.Now().UnixNano())
	n := len(this.nums)
	for i := n - 1; i > 0; i-- {
		j := rand.Intn(i + 1)
		this.nums[i], this.nums[j] = this.nums[j], this.nums[i]
	}
	return this.nums
}