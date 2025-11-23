func mostFrequentPrime(mat [][]int) int {
    directions := [][]int{
        {1, 0}, {1, 1}, {0, 1}, {-1, 1},
        {-1, 0}, {-1, -1}, {0, -1}, {1, -1},
    }
    m, n := len(mat), len(mat[0])
    primeCount := make(map[int]int)

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            for _, dir := range directions {
                x, y := i, j
                num := 0
                for x >= 0 && x < m && y >= 0 && y < n {
                    num = num*10 + mat[x][y]
                    if num > 10 && isPrime(num) {
                        primeCount[num]++
                    }
                    x += dir[0]
                    y += dir[1]
                }
            }
        }
    }

    maxFreq := 0
    result := -1
    for num, freq := range primeCount {
        if freq > maxFreq || (freq == maxFreq && num > result) {
            maxFreq = freq
            result = num
        }
    }

    return result
}

func isPrime(num int) bool {
    if num <= 1 {
        return false
    }
    if num == 2 {
        return true
    }
    if num%2 == 0 {
        return false
    }
    for i := 3; i*i <= num; i += 2 {
        if num%i == 0 {
            return false
        }
    }
    return true
}