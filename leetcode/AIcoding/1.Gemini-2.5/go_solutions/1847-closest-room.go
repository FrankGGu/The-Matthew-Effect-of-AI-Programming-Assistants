package main

import (
	"math"
	"sort"
)

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func closestRoom(rooms [][]int, queries [][]int) []int {
	type query struct {
		preferredID int
		minSize     int
		originalIdx int
	}

	queriesWithIdx := make([]query, len(queries))
	for i, q := range queries {
		queriesWithIdx[i] = query{q[0], q[1], i}
	}

	sort.Slice(queriesWithIdx, func(i, j int) bool {
		return queriesWithIdx[i].minSize > queriesWithIdx[j].minSize
	})

	sort.Slice(rooms, func(i, j int) bool {
		return rooms[i][1] > rooms[j][1] // Sort rooms by size descending
	})

	ans := make([]int, len(queries))
	activeRoomIDs := make(map[int]struct{})
	roomPtr := 0

	for _, q := range queriesWithIdx {
		preferredID := q.preferredID
		minSize := q.minSize
		originalIdx := q.originalIdx

		for roomPtr < len(rooms) && rooms[roomPtr][1] >= minSize {
			activeRoomIDs[rooms[roomPtr][0]] = struct{}{}
			roomPtr++
		}

		if len(activeRoomIDs) == 0 {
			ans[originalIdx] = -1
			continue
		}

		currentIDs := make([]int, 0, len(activeRoomIDs))
		for id := range activeRoomIDs {
			currentIDs = append(currentIDs, id)
		}
		sort.Ints(currentIDs)

		bestRoomID := -1
		minDiff := math.MaxInt32

		idx := sort.SearchInts(currentIDs, preferredID)

		// Check ceiling (value >= preferredID)
		if idx < len(currentIDs) {
			ceilVal := currentIDs[idx]
			diff := abs(ceilVal - preferredID)
			minDiff = diff
			bestRoomID = ceilVal
		}

		// Check floor (value <= preferredID)
		if idx > 0 {
			floorVal := currentIDs[idx-1]
			diff := abs(floorVal - preferredID)
			if diff < minDiff {
				minDiff = diff
				bestRoomID = floorVal
			} else if diff == minDiff {
				bestRoomID = min(bestRoomID, floorVal)
			}
		}
		ans[originalIdx] = bestRoomID
	}

	return ans
}