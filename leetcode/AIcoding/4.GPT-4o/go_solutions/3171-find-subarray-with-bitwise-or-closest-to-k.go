func findBestSubarray(arr []int, K int) []int {
    n := len(arr)
    closest := math.MaxInt32
    bestL, bestR := -1, -1

    for l := 0; l < n; l++ {
        currOR := 0
        for r := l; r < n; r++ {
            currOR |= arr[r]
            if abs(currOR-K) < abs(closest-K) || (abs(currOR-K) == abs(closest-K) && r-l < bestR-bestL) {
                closest = currOR
                bestL, bestR = l, r
            }
        }
    }

    if bestL == -1 {
        return []int{}
    }
    return arr[bestL : bestR+1]
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}