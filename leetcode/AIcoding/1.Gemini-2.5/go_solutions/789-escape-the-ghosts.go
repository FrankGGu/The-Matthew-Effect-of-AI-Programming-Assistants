package main

import "math"

func escapeGhosts(ghosts [][]int, target []int) bool {
	playerDist := int(math.Abs(float64(target[0])) + math.Abs(float64(target[1])))

	for _, ghost := range ghosts {
		ghostDist := int(math.Abs(float64(target[0]-ghost[0])) + math.Abs(float64(target[1]-ghost[1])))
		if ghostDist <= playerDist {
			return false
		}
	}

	return true
}