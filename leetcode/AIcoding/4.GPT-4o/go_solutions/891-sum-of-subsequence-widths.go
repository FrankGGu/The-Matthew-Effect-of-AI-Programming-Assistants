import "sort"

func sumSubseqWidths(A []int) int {
    sort.Ints(A)
    n := len(A)
    mod := 1000000007
    result := 0
    power := 1

    for i := 0; i < n; i++ {
        result = (result + (A[i] * power) % mod) % mod
        power = (power * 2) % mod
    }

    power = 1
    for i := n - 1; i >= 0; i-- {
        result = (result - (A[i] * power) % mod + mod) % mod
        power = (power * 2) % mod
    }

    return result
}