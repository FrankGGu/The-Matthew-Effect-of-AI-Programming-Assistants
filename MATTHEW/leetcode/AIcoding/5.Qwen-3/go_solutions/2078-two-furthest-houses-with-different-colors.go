package main

func maxDistance(colors []int) int {
	n := len(colors)
	maxDist := 0
	for i := 0; i < n; i++ {
		for j := n - 1; j > i; j-- {
			if colors[i] != colors[j] {
				if j-i > maxDist {
					maxDist = j - i
				}
				break
			}
		}
	}
	return maxDist
}