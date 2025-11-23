func findPrimePairs(n int) [][]int {
    if n < 2 {
        return [][]int{}
    }

    isPrime := make([]bool, n+1)
    for i := 2; i <= n; i++ {
        isPrime[i] = true
    }

    for i := 2; i*i <= n; i++ {
        if isPrime[i] {
            for j := i * i; j <= n; j += i {
                isPrime[j] = false
            }
        }
    }

    var res [][]int
    for x := 2; x <= n/2; x++ {
        y := n - x
        if y >= x && isPrime[x] && isPrime[y] {
            res = append(res, []int{x, y})
        }
    }

    return res
}