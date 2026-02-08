package main

import (
	"sort"
)

func avoidFlood(rains []int) []int {
	n := len(rains)
	ans := make([]int, n)

	// lastRainDay stores the last day a city rained.
	// city -> day_index
	lastRainDay := make(map[int]int)

	// dryDays stores indices of days when rains[i] == 0 (dry days).
	// This slice will be kept sorted to efficiently find the next available dry day.
	dryDays := []int{}

	for i := 0; i < n; i++ {
		city := rains[i]

		if city == 0 {
			// This is a dry day. Add its index to the sorted dryDays slice.
			// Default ans[i] to 1, as per problem statement (any positive integer if not used).
			// This value will be overridden if this dry day is assigned to a specific lake.
			ans[i] = 1 

			// Insert 'i' into dryDays while maintaining sorted order.
			// sort.SearchInts finds the index where 'i' should be inserted to maintain order.
			idx := sort.SearchInts(dryDays, i)
			dryDays = append(dryDays, 0)         // Grow slice by one
			copy(dryDays[idx+1:], dryDays[idx:]) // Shift elements to the right
			dryDays[idx] = i                     // Insert 'i'
		} else {
			// It rains on 'city'.
			// As per problem statement, ans[i] is -1 if it rains on day i.
			ans[i] = -1 

			if prevRainDay, exists := lastRainDay[city]; exists {
				// This city rained before (at prevRainDay) and is now raining again (at i).
				// It means the city was flooded and needs to be dried on some day 'd'
				// such that prevRainDay < d < i.
				// We need to find the earliest such 'd' from the available dry days.

				// Find the index of the first dry day 'd' in dryDays such that d >= prevRainDay + 1.
				idx := sort.SearchInts(dryDays, prevRainDay+1)

				if idx == len(dryDays) {
					// No available dry day found after prevRainDay.
					// It's impossible to avoid a flood.
					return []int{}
				}

				// dryDays[idx] is the earliest available dry day for 'city'.
				// Assign this dry day to 'city'.
				ans[dryDays[idx]] = city

				// Remove the used dry day from the dryDays slice.
				// This operation takes O(N) time in the worst case, where N is len(dryDays).
				dryDays = append(dryDays[:idx], dryDays[idx+1:]...)
			}
			// Update the last rain day for this city to the current day.
			lastRainDay[city] = i
		}
	}

	return ans
}