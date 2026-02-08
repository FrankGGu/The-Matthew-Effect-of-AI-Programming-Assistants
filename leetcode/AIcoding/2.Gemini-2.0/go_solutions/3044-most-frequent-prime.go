import (
	"strconv"
)

func mostFrequentPrime(mat [][]int) int {
	m := len(mat)
	n := len(mat[0])
	count := make(map[int]int)
	maxFreq := 0
	result := -1

	isPrime := func(num int) bool {
		if num <= 1 {
			return false
		}
		for i := 2; i*i <= num; i++ {
			if num%i == 0 {
				return false
			}
		}
		return true
	}

	var dfs func(i, j, di, dj int)
	dfs = func(i, j, di, dj int) {
		numStr := ""
		for i >= 0 && i < m && j >= 0 && j < n {
			numStr += strconv.Itoa(mat[i][j])
			num, _ := strconv.Atoi(numStr)
			if len(numStr) > 1 && num > 10 && isPrime(num) {
				count[num]++
				if count[num] > maxFreq {
					maxFreq = count[num]
					result = num
				} else if count[num] == maxFreq && num > result {
					result = num
				}
			}
			i += di
			j += dj
		}
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			dfs(i, j, 0, 1)   // right
			dfs(i, j, 1, 0)   // down
			dfs(i, j, 1, 1)   // diagonal
			dfs(i, j, 1, -1)  // anti-diagonal
		}
	}

	return result
}