type Solution struct {
    prefixSum []int
    totalSum  int
}

func Constructor(w []int) Solution {
    prefixSum := make([]int, len(w))
    prefixSum[0] = w[0]
    for i := 1; i < len(w); i++ {
        prefixSum[i] = prefixSum[i-1] + w[i]
    }
    return Solution{
        prefixSum: prefixSum,
        totalSum:  prefixSum[len(prefixSum)-1],
    }
}

func (this *Solution) PickIndex() int {
    target := rand.Intn(this.totalSum) + 1
    left, right := 0, len(this.prefixSum)-1
    for left < right {
        mid := left + (right-left)/2
        if this.prefixSum[mid] < target {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}