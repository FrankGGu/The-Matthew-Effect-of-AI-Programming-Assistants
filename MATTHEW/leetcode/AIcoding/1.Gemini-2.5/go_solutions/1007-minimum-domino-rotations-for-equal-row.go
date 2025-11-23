package main

import "math"

func minDominoRotations(A []int, B []int) int {
	n := len(A)

	check := func(x int) int {
		rotationsA := 0
		rotationsB := 0

		for i := 0; i < n; i++ {
			if A[i] != x && B[i] != x {
				return -1
			}
			if A[i] != x {
				rotationsA++
			}
			if B[i] != x {
				rotationsB++
			}
		}
		return int(math.Min(float64(rotationsA), float64(rotationsB)))
	}

	ans1 := check(A[0])
	ans2 := -1
	if A[0] != B[0] {
		ans2 = check(B[0])
	}

	if ans1 == -1 && ans2 == -1 {
		return -1
	} else if ans1 == -1 {
		return ans2
	} else if ans2 == -1 {
		return ans1
	} else {
		return int(math.Min(float64(ans1), float64(ans2)))
	}
}