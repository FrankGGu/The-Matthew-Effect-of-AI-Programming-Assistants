import (
	"math/rand"
	"time"
)

type Solution struct {
	prefixSums []int
	totalSum   int
}

func Constructor(w []int) Solution {
	rand.Seed(time.Now().UnixNano())
	prefixSums := make([]int, len(w))
	prefixSums[0] = w[0]
	for i := 1; i < len(w); i++ {
		prefixSums[i] = prefixSums[i-1] + w[i]
	}
	return Solution{prefixSums: prefixSums, totalSum: prefixSums[len(w)-1]}
}

func (this *Solution) PickIndex() int {
	target := rand.Intn(this.totalSum) + 1
	low, high := 0, len(this.prefixSums)-1
	for low <= high {
		mid := low + (high-low)/2
		if this.prefixSums[mid] < target {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}
	return low
}