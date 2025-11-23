package main

func maxPoints(points [][]int) int {
	n := len(points)
	if n <= 2 {
		return n
	}

	maxP := 0

	gcd := func(a, b int) int {
		if a < 0 {
			a = -a
		}
		if b < 0 {
			b = -b
		}
		for b != 0 {
			a, b = b, a%b
		}
		return a
	}

	for i := 0; i < n; i++ {
		slopeCounts := make(map[[2]int]int)
		samePoints := 0
		currentMaxOnLine := 0

		for j := i + 1; j < n; j++ {
			p1 := points[i]
			p2 := points[j]

			if p1[0] == p2[0] && p1[1] == p2[1] {
				samePoints++
				continue
			}

			dy := p2[1] - p1[1]
			dx := p2[0] - p1[0]

			commonDivisor := gcd(dy, dx)

			dy /= commonDivisor
			dx /= commonDivisor

			if dx < 0 || (dx == 0 && dy < 0) {
				dx = -dx
				dy = -dy
			}

			key := [2]int{dy, dx}
			slopeCounts[key]++
			currentMaxOnLine = max(currentMaxOnLine, slopeCounts[key])
		}

		maxP = max(maxP, currentMaxOnLine+samePoints+1)
	}

	return maxP
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}