package main

import (
	"sort"
)

type Seed struct {
	plant int
	grow  int
}

type Seeds []Seed

func (s Seeds) Len() int {
	return len(s)
}

func (s Seeds) Less(i, j int) bool {
	return s[i].grow > s[j].grow
}

func (s Seeds) Swap(i, j int) {
	s[i], s[j] = s[j], s[i]
}

func earliestFullBloom(plantTime []int, growTime []int) int {
	n := len(plantTime)
	seeds := make(Seeds, n)

	// Populate the seeds slice with plant and grow times.
	for i := 0; i < n; i++ {
		seeds[i] = Seed{plant: plantTime[i], grow: growTime[i]}
	}

	// Sort seeds in descending order of their grow time.
	sort.Sort(seeds)

	currentTime := 0    // Tracks the cumulative time spent planting seeds.
	maxBloomTime := 0 // Tracks the maximum bloom time observed so far.

	// Iterate through the sorted seeds and calculate bloom times.
	for _, seed := range seeds {
		// The current seed starts planting at `currentTime`.
		// It finishes planting at `currentTime + seed.plant`.
		// It starts growing immediately after planting and blooms at `currentTime + seed.plant + seed.grow`.
		bloomFinishTime := currentTime + seed.plant + seed.grow

		// Update the overall maximum bloom time if this seed blooms later.
		if bloomFinishTime > maxBloomTime {
			maxBloomTime = bloomFinishTime
		}

		// Update `currentTime` for the next seed.
		// The next seed can start planting only after the current seed's planting is complete.
		currentTime += seed.plant
	}

	return maxBloomTime
}