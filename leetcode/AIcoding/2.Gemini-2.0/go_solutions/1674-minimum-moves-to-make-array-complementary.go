func minMoves(nums []int, limit int) int {
    n := len(nums)
    diff := make([]int, 2*limit+2)

    for i := 0; i < n/2; i++ {
        a := nums[i]
        b := nums[n-1-i]

        diff[2] += 2
        diff[min(a, b)+1] -= 1
        diff[a+b] -= 1
        diff[a+b+1] += 1
        diff[max(a, b)+limit+1] += 1
    }

    ans := n
    curr := 0
    for i := 2; i <= 2*limit; i++ {
        curr += diff[i]
        ans = min(ans, curr)
    }

    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}