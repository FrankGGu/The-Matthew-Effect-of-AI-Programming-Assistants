import (
	"sort"
)

func videoStitching(clips [][]int, T int) int {
	sort.Slice(clips, func(i, j int) bool {
		return clips[i][0] < clips[j][0]
	})

	clipsCount := 0
	currentReach := 0   
	maxReachInStep := 0 

	clipIdx := 0 

	for currentReach < T {
		prevCurrentReach := currentReach

		for clipIdx < len(clips) && clips[clipIdx][0] <= prevCurrentReach {
			if clips[clipIdx][1] > maxReachInStep {
				maxReachInStep = clips[clipIdx][1]
			}
			clipIdx++
		}

		if maxReachInStep <= prevCurrentReach {
			return -1
		}

		currentReach = maxReachInStep
		clipsCount++
	}

	return clipsCount
}