func countWays(buildings []int) int {
    mod := 1000000007
    n := len(buildings)
    left := make([]int, n)
    right := make([]int, n)

    left[0] = 1
    for i := 1; i < n; i++ {
        if buildings[i-1] == 1 {
            left[i] = left[i-1]
        } else {
            left[i] = (left[i-1] + 1) % mod
        }
    }

    right[n-1] = 1
    for i := n - 2; i >= 0; i-- {
        if buildings[i+1] == 1 {
            right[i] = right[i+1]
        } else {
            right[i] = (right[i+1] + 1) % mod
        }
    }

    result := 0
    for i := 0; i < n; i++ {
        if buildings[i] == 0 {
            result = (result + left[i] * right[i]) % mod
        }
    }

    return result
}