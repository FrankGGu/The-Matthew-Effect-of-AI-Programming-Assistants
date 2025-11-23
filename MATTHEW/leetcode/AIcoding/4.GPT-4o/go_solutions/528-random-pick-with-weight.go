import "math/rand"

type Solution struct {
    prefixSums []int
    total      int
}

func Constructor(w []int) Solution {
    prefixSums := make([]int, len(w))
    total := 0
    for i, weight := range w {
        total += weight
        prefixSums[i] = total
    }
    return Solution{prefixSums, total}
}

func (this *Solution) PickIndex() int {
    target := rand.Intn(this.total)
    left, right := 0, len(this.prefixSums)-1
    for left < right {
        mid := left + (right-left)/2
        if this.prefixSums[mid] <= target {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}