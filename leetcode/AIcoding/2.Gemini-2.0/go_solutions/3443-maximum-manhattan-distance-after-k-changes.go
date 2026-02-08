import (
	"fmt"
	"math"
)

func maxManhattan(points [][]int, k int) int {
	maxDist := 0
	for _, p := range points {
		for _, q := range points {
			dist := abs(p[0]-q[0]) + abs(p[1]-q[1])
			maxDist = max(maxDist, dist)
		}
	}

	n := len(points)
	maxDistAfterK := 0

	for i := 0; i < (1 << (2 * n)); i++ {
		if countSetBits(i) > k {
			continue
		}

		tempPoints := make([][]int, n)
		for j := 0; j < n; j++ {
			tempPoints[j] = make([]int, 2)
			tempPoints[j][0] = points[j][0]
			tempPoints[j][1] = points[j][1]
		}

		bitsUsed := 0
		for j := 0; j < n; j++ {
			if bitsUsed + 2 > k {
				break
			}
			if (i>> (2*j)) & 1 == 1 {
				tempPoints[j][0]++
				bitsUsed++
			}
			if (i>> (2*j+1)) & 1 == 1 {
				tempPoints[j][0]--
				bitsUsed++
			}
		}

		remainingK := k - bitsUsed
		for j := 0; j < (1 << (2 * n)); j++ {
			if countSetBits(j) > remainingK {
				continue
			}

			tempPoints2 := make([][]int, n)
			for l := 0; l < n; l++ {
				tempPoints2[l] = make([]int, 2)
				tempPoints2[l][0] = tempPoints[l][0]
				tempPoints2[l][1] = tempPoints[l][1]
			}

			bitsUsed2 := 0
			for l := 0; l < n; l++ {
				if bitsUsed2 + 2 > remainingK {
					break
				}

				if (j>> (2*l)) & 1 == 1 {
					tempPoints2[l][1]++
					bitsUsed2++
				}

				if (j>> (2*l+1)) & 1 == 1 {
					tempPoints2[l][1]--
					bitsUsed2++
				}
			}

			maxDistTemp := 0
			for _, p := range tempPoints2 {
				for _, q := range tempPoints2 {
					dist := abs(p[0]-q[0]) + abs(p[1]-q[1])
					maxDistTemp = max(maxDistTemp, dist)
				}
			}

			maxDistAfterK = max(maxDistAfterK, maxDistTemp)

		}

	}

	return maxDistAfterK
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func countSetBits(n int) int {
	count := 0
	for n > 0 {
		n &= (n - 1)
		count++
	}
	return count
}