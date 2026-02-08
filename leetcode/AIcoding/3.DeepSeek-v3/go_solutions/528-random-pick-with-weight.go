import (
	"math/rand"
	"sort"
)

type Solution struct {
	prefix []int
}

func Constructor(w []int) Solution {
	prefix := make([]int, len(w))
	prefix[0] = w[0]
	for i := 1; i < len(w); i++ {
		prefix[i] = prefix[i-1] + w[i]
	}
	return Solution{prefix: prefix}
}

func (this *Solution) PickIndex() int {
	target := rand.Intn(this.prefix[len(this.prefix)-1]) + 1
	return sort.SearchInts(this.prefix, target)
}