package main

import (
	"math"
	"sort"
)

type Mole struct {
	x, y, t int
}

type Moles []Mole

func (m Moles) Len() int           { return len(m) }
func (m Moles) Less(i, j int) bool { return m[i].t < m[j].t } // Sort by time
func (m Moles) Swap(i, j int)      { m[i], m[j] = m[j], m[i] }

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func whackAMole(points [][]int) int {
	if len(points) == 0 {
		return 0
	}

	// Convert input [][]int to []Mole for easier handling
	moles := make([]Mole, len(points))
	for i, p := range points {
		moles[i] = Mole{x: p[0], y: p[1], t: p[2]}
	}

	// Sort moles by their appearance time
	sort.Sort(Moles(moles))

	n := len(moles)
	// dp[i] stores the maximum number of moles that can be hit, ending with mole i
	dp := make([]int, n)
	maxMoles := 0

	for i := 0; i < n; i++ {
		dp[i] = 1 // A single mole can always be hit by itself
		// Iterate through all previous moles (moles with earlier appearance times)
		for j := 0; j < i; j++ {
			// Calculate time difference and Manhattan distance
			timeDiff := moles[i].t - moles[j].t
			dist := abs(moles[i].x-moles[j].x) + abs(moles[i].y-moles[j].y)

			// If it's possible to hit mole i after hitting mole j
			// (time elapsed must be greater than or equal to distance moved)
			if timeDiff >= dist {
				// Update dp[i] if hitting mole j then mole i yields more moles
				dp[i] = int(math.Max(float64(dp[i]), float64(dp[j]+1)))
			}
		}
		// Keep track of the overall maximum number of moles hit
		maxMoles = int(math.Max(float64(maxMoles), float64(dp[i])))
	}

	return maxMoles
}