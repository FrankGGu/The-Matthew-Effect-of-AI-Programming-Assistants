func diagonalPrime(mat [][]int) int {
    maxPrime := 0
    isPrime := func(n int) bool {
        if n < 2 {
            return false
        }
        for i := 2; i*i <= n; i++ {
            if n%i == 0 {
                return false
            }
        }
        return true
    }

    n := len(mat)
    for i := 0; i < n; i++ {
        if isPrime(mat[i][i]) && mat[i][i] > maxPrime {
            maxPrime = mat[i][i]
        }
        if isPrime(mat[i][n-1-i]) && mat[i][n-1-i] > maxPrime {
            maxPrime = mat[i][n-1-i]
        }
    }
    return maxPrime
}