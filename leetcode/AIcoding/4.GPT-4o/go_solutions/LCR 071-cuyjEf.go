type Solution struct {
    prefixSums []int
    totalSum   int
}

func Constructor(w []int) Solution {
    prefixSums := make([]int, len(w))
    totalSum := 0
    for i, weight := range w {
        totalSum += weight
        prefixSums[i] = totalSum
    }
    return Solution{prefixSums: prefixSums, totalSum: totalSum}
}

func (this *Solution) PickIndex() int {
    target := rand.Intn(this.totalSum)
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