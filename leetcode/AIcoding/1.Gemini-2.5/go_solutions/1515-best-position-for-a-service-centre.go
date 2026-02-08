package main

import (
	"math"
)

func getMinDistSum(points [][]int) float64 {
	n := len(points)
	if n == 0 {
		return 0.0
	}

	// Initial guess: Centroid of the points
	var sumX, sumY float64
	for _, p := range points {
		sumX += float64(p[0])
		sumY += float64(p[1])
	}
	currentX := sumX / float64(n)
	currentY := sumY / float64(n)

	// Helper function to calculate total distance for a given center (cx, cy)
	calculateTotalDistance := func(cx, cy float64) float64 {
		totalDist := 0.0
		for _, p := range points {
			dx := float64(p[0]) - cx
			dy := float64(p[1]) - cy
			totalDist += math.Sqrt(dx*dx + dy*dy)
		}
		return totalDist
	}

	minDist := calculateTotalDistance(currentX, currentY)

	// Optimization using a gradient-descent like approach with decreasing step size
	delta := 100.0 // Initial step size, large enough to cover the coordinate range

	// Directions to explore (4 cardinal directions)
	directions := [][]float64{
		{1, 0}, {-1, 0}, {0, 1}, {0, -1},
	}

	// Loop until step size is very small, indicating convergence
	for delta > 1e-7 {
		foundBetter := false
		for _, dir := range directions {
			newX := currentX + dir[0]*delta
			newY := currentY + dir[1]*delta

			newDist := calculateTotalDistance(newX, newY)

			if newDist < minDist {
				minDist = newDist
				currentX = newX
				currentY = newY
				foundBetter = true
			}
		}

		// If no improvement in any direction, reduce step size
		if !foundBetter {
			delta /= 2.0
		}
	}

	return minDist
}