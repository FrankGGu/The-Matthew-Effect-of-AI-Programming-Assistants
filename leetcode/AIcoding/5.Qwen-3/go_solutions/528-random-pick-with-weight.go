package main

type Solution struct {
    prefixSums []int
}

func Constructor(w []int) Solution {
    prefixSums := make([]int, len(w))
    prefixSums[0] = w[0]
    for i := 1; i < len(w); i++ {
        prefixSums[i] = prefixSums[i-1] + w[i]
    }
    return Solution{prefixSums}
}

func (this *Solution) PickIndex() int {
    n := len(this.prefixSums)
    target := rand.Intn(this.prefixSums[n-1]) + 1
    left, right := 0, n-1
    for left < right {
        mid := left + (right-left)/2
        if this.prefixSums[mid] < target {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}