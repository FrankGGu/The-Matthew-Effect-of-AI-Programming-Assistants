func squareFreeSubsets(nums []int) int {
    const mod = 1_000_000_007
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    isSquareFree := func(x int) bool {
        for i := 2; i*i <= x; i++ {
            if x%(i*i) == 0 {
                return false
            }
        }
        return true
    }

    squareFreeNums := []int{}
    for num := range count {
        if isSquareFree(num) {
            squareFreeNums = append(squareFreeNums, num)
        }
    }

    dp := make([]int, len(squareFreeNums)+1)
    dp[0] = 1

    for i := 0; i < len(squareFreeNums); i++ {
        num := squareFreeNums[i]
        for j := 1; j <= count[num]; j++ {
            for k := len(squareFreeNums); k >= 0; k-- {
                if k-j >= 0 {
                    dp[k] = (dp[k] + dp[k-j]) % mod
                }
            }
        }
    }

    result := 0
    for i := 1; i <= len(squareFreeNums); i++ {
        result = (result + dp[i]) % mod
    }

    return result
}