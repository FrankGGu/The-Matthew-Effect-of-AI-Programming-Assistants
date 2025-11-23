func findMinimumCostPermutation(nums []int) []int {
    n := len(nums)
    minCost := math.MaxInt32
    bestPerm := make([]int, n)
    perm := make([]int, n)
    used := make([]bool, n)

    var backtrack func(int, int)
    backtrack = func(pos, currentCost int) {
        if pos == n {
            if currentCost < minCost {
                minCost = currentCost
                copy(bestPerm, perm)
            }
            return
        }

        for i := 0; i < n; i++ {
            if !used[i] {
                used[i] = true
                perm[pos] = nums[i]
                newCost := currentCost
                if pos > 0 {
                    newCost += abs(perm[pos-1] - perm[pos])
                }
                if newCost < minCost {
                    backtrack(pos+1, newCost)
                }
                used[i] = false
            }
        }
    }

    backtrack(0, 0)
    return bestPerm
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}