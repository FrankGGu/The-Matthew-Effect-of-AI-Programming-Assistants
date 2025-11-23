package main

import (
	"math"
)

func bestCoordinate(towers [][]int, radius int) []int {
	maxQuality := -1
	bestX, bestY := 0, 0

	for x := 0; x <= 50; x++ {
		for y := 0; y <= 50; y++ {
			currentQuality := 0
			for _, tower := range towers {
				tx, ty, q := tower[0], tower[1], tower[2]

				distSq := (x-tx)*(x-tx) + (y-ty)*(y-ty)
				dist := math.Sqrt(float64(distSq))

				if dist <= float64(radius) {
					currentQuality += int(float64(q) / (1 + dist))
				}
			}

			if currentQuality > maxQuality {
				maxQuality = currentQuality
				bestX, bestY = x, y
			}
		}
	}

	return []int{bestX, bestY}
}