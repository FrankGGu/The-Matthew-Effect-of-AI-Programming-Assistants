package main

import (
	"sort"
)

func maxEnvelopes(envelopes [][]int) int {
	if len(envelopes) == 0 {
		return 0
	}

	sort.Slice(envelopes, func(i, j int) bool {
		if envelopes[i][0] != envelopes[j][0] {
			return envelopes[i][0] < envelopes[j][0]
		}
		return envelopes[i][1] > envelopes[j][1]
	})

	tails := []int{}
	for _, env := range envelopes {
		h := env[1]

		idx := sort.SearchInts(tails, h)

		if idx == len(tails) {
			tails = append(tails, h)
		} else {
			tails[idx] = h
		}
	}

	return len(tails)
}