package main

func mostFrequentPrime(matrix [][]int) int {
    rows := len(matrix)
    cols := len(matrix[0])
    freq := make(map[int]int)

    for i := 0; i < rows; i++ {
        for j := 0; j < cols; j++ {
            for di := -1; di <= 1; di++ {
                for dj := -1; dj <= 1; dj++ {
                    if di == 0 && dj == 0 {
                        continue
                    }
                    num := 0
                    x, y := i, j
                    for x >= 0 && x < rows && y >= 0 && y < cols {
                        num = num*10 + matrix[x][y]
                        freq[num]++
                        x += di
                        y += dj
                    }
                }
            }
        }
    }

    maxFreq := 0
    result := -1
    for prime, count := range freq {
        if isPrime(prime) && count > maxFreq {
            maxFreq = count
            result = prime
        }
    }
    return result
}

func isPrime(n int) bool {
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