func getTriggerTime(increase [][]int, requirements [][]int) []int {
    n := len(increase)
    prefix := make([][3]int, n+1)
    for i := 1; i <= n; i++ {
        prefix[i][0] = prefix[i-1][0] + increase[i-1][0]
        prefix[i][1] = prefix[i-1][1] + increase[i-1][1]
        prefix[i][2] = prefix[i-1][2] + increase[i-1][2]
    }
    res := make([]int, len(requirements))
    for i, req := range requirements {
        c, r, h := req[0], req[1], req[2]
        left, right := 0, n
        for left < right {
            mid := left + (right-left)/2
            if prefix[mid][0] >= c && prefix[mid][1] >= r && prefix[mid][2] >= h {
                right = mid
            } else {
                left = mid + 1
            }
        }
        if left <= n && prefix[left][0] >= c && prefix[left][1] >= r && prefix[left][2] >= h {
            res[i] = left
        } else {
            res[i] = -1
        }
    }
    return res
}