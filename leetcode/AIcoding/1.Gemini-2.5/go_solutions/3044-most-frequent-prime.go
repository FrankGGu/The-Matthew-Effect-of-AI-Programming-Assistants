package main

import (
	"math"
)

func isPrime(n int64) bool {
	if n < 2 {
		return false
	}
	if n == 2 {
		return true
	}
	if n%2 == 0 {
		return false
	}
	limit := int64(math.Sqrt(float64(n)))
	for i := int64(3); i <= limit; i += 2 {
		if n%i == 0 {
			return false
		}
	}
	return true
}

func mostFrequentPrime(grid [][]int) int {
	m := len(grid)
	n := len(grid[0])

	freqMap := make(map[int64]int)

	dr := []int{-1, 1, 0, 0, -1, -1, 1, 1}
	dc := []int{0, 0, -1, 1, -1, 1, -1, 1}

	for r := 0; r < m; r++ {
		for c := 0; c < n; c++ {
			for k := 0; k < 8; k++ {
				currNum := int64(0)
				nr, nc := r, c

				for {
					if nr < 0 || nr >= m || nc < 0 || nc >= n {
						break
					}

					currNum = currNum*10 + int64(grid[nr][nc])

					if currNum > 10 && isPrime(currNum) {
						freqMap[currNum]++
					}

					nr += dr[k]
					nc += dc[k]
				}
			}
		}
	}

	maxFreq := -1
	resultPrime := int64(-1)

	for prime, count := range freqMap {
		if count > maxFreq {
			maxFreq = count
			resultPrime = prime
		} else if count == maxFreq {
			if prime > resultPrime {
				resultPrime = prime
			}
		}
	}

	return int(resultPrime)
}