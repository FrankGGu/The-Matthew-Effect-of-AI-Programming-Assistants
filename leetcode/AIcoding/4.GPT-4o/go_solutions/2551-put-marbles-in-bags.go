import "sort"

func putMarbles(weights []int, k int) int {
    n := len(weights)
    if k == 1 {
        return 0
    }

    minWeight := 0
    maxWeight := 0

    pairs := make([]int, n-1)
    for i := 0; i < n-1; i++ {
        pairs[i] = weights[i] + weights[i+1]
    }

    sort.Ints(pairs)

    for i := 0; i < k-1; i++ {
        minWeight += pairs[i]
    }

    for i := n - 2; i >= n-k+1; i-- {
        maxWeight += pairs[i]
    }

    return maxWeight - minWeight
}