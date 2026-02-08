func minimumCost(nums []int) int64 {
    sort.Ints(nums)
    n := len(nums)
    median := nums[n/2]

    candidates := []int{median}
    lower := median - 1
    upper := median + 1

    for len(candidates) < 5 {
        if lower >= 0 {
            candidates = append(candidates, lower)
            lower--
        }
        if upper <= 1e9 {
            candidates = append(candidates, upper)
            upper++
        }
    }

    minCost := int64(math.MaxInt64)
    for _, cand := range candidates {
        if isPalindromic(cand) {
            cost := int64(0)
            for _, num := range nums {
                cost += int64(abs(num - cand))
            }
            if cost < minCost {
                minCost = cost
            }
        }
    }
    return minCost
}

func isPalindromic(x int) bool {
    s := strconv.Itoa(x)
    left, right := 0, len(s)-1
    for left < right {
        if s[left] != s[right] {
            return false
        }
        left++
        right--
    }
    return true
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}