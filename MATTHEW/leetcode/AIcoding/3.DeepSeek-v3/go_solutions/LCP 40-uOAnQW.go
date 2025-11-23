func maxmiumScore(cards []int, cnt int) int {
    var odd, even []int
    for _, num := range cards {
        if num%2 == 1 {
            odd = append(odd, num)
        } else {
            even = append(even, num)
        }
    }
    sort.Sort(sort.Reverse(sort.IntSlice(odd)))
    sort.Sort(sort.Reverse(sort.IntSlice(even)))

    prefixOdd := make([]int, len(odd)+1)
    for i := 1; i <= len(odd); i++ {
        prefixOdd[i] = prefixOdd[i-1] + odd[i-1]
    }
    prefixEven := make([]int, len(even)+1)
    for i := 1; i <= len(even); i++ {
        prefixEven[i] = prefixEven[i-1] + even[i-1]
    }

    maxSum := 0
    for k := 0; k <= cnt; k += 2 {
        if k <= len(odd) && (cnt-k) <= len(even) && (cnt-k) >= 0 {
            sum := prefixOdd[k] + prefixEven[cnt-k]
            if sum > maxSum {
                maxSum = sum
            }
        }
    }
    return maxSum
}