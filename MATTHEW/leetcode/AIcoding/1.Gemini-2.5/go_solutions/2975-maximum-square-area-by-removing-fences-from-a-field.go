package main

import (
	"sort"
)

func maximumSquareArea(m int, n int, hFences []int, vFences []int) int {
	mod := 1_000_000_007

	hCoordsMap := make(map[int]bool)
	hCoordsMap[0] = true
	hCoordsMap[m+1] = true
	for _, h := range hFences {
		hCoordsMap[h] = true
	}
	hLines := make([]int, 0, len(hCoordsMap))
	for coord := range hCoordsMap {
		hLines = append(hLines, coord)
	}
	sort.Ints(hLines)

	vCoordsMap := make(map[int]bool)
	vCoordsMap[0] = true
	vCoordsMap[n+1] = true
	for _, v := range vFences {
		vCoordsMap[v] = true
	}
	vLines := make([]int, 0, len(vCoordsMap))
	for coord := range vCoordsMap {
		vLines = append(vLines, coord)
	}
	sort.Ints(vLines)

	hDistances := make(map[int]bool)
	for i := 0; i < len(hLines); i++ {
		for j := i + 1; j < len(hLines); j++ {
			hDistances[hLines[j]-hLines[i]] = true
		}
	}

	vDistances := make(map[int]bool)
	for i := 0; i < len(vLines); i++ {
		for j := i + 1; j < len(vLines); j++ {
			vDistances[vLines[j]-vLines[i]] = true
		}
	}

	maxSide := 0
	for dist := range hDistances {
		if vDistances[dist] {
			if dist > maxSide {
				maxSide = dist
			}
		}
	}

	if maxSide == 0 {
		return -1
	}

	area := (int64(maxSide) * int64(maxSide)) % int64(mod)
	return int(area)
}