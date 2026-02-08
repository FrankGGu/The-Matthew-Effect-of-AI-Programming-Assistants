func numFriendRequests(ages []int) int {
    count := make([]int, 121)
    for _, age := range ages {
        count[age]++
    }

    prefixSum := make([]int, 121)
    for i := 1; i <= 120; i++ {
        prefixSum[i] = prefixSum[i-1] + count[i]
    }

    res := 0
    for a := 1; a <= 120; a++ {
        if count[a] == 0 {
            continue
        }
        minB := a/2 + 7
        if minB >= a {
            continue
        }
        maxB := a
        cnt := prefixSum[maxB] - prefixSum[minB] - 1
        res += cnt * count[a]
    }
    return res
}