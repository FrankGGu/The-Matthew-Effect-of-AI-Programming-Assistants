package main

import "math"

func minimumSeconds(heights []int) int {
	n := len(heights)
	if n == 0 {
		return 0
	}

	maxVal := 0
	for _, h := range heights {
		if h > maxVal {
			maxVal = h
		}
	}

	// If all mountains are already zero, return 0.
	if maxVal == 0 {
		return 0
	}

	// Find all indices where height is maxVal.
	maxIndices := []int{}
	for i := 0; i < n; i++ {
		if heights[i] == maxVal {
			maxIndices = append(maxIndices, i)
		}
	}

	// Check if any two maxVal mountains are adjacent.
	// If so, neither can be a peak relative to the other.
	// They will only reduce by 1 (manual reduction).
	// In this case, the answer is maxVal.
	// All other mountains (with height < maxVal) can also be reduced by 1 manually.
	// If they are peaks, they also erode, reducing faster.
	// So, the maxVal mountains (that are not peaks) will be the bottleneck.
	for i := 0; i < len(maxIndices); i++ {
		currIdx := maxIndices[i]
		nextIdx := maxIndices[(i+1)%len(maxIndices)]
		if (nextIdx-currIdx+n)%n == 1 { // Check if adjacent (circularly)
			return maxVal
		}
	}

	// If all maxVal mountains are separated, they are all peaks.
	// They will reduce by 2 per second (1 manual + 1 erosion).
	// So, the time for them to become zero is ceil(maxVal / 2).
	// This is our initial candidate for the answer.
	ans := (maxVal + 1) / 2 // ceil(maxVal / 2)

	// Now consider the mountains between two maxVal mountains.
	// These mountains (heights[x] < maxVal) are reduced by 1 manually.
	// They also get erosion if they become peaks.
	// The "erosion wave" propagates from the maxVal mountains.
	// A mountain heights[x] at distance 'd' from a maxVal mountain.
	// After 'd' seconds, heights[x] has been reduced by 'd' (manual).
	// Its neighbors (which are part of the maxVal wave) have also been reduced.
	// At this point, heights[x] will be at the "erosion front" and will start eroding (reducing by 2).
	// So, the total time for heights[x] is d + ceil((heights[x] - d) / 2).
	// We need to find the maximum of these values over all mountains.

	// Iterate through segments between consecutive maxVal mountains.
	for i := 0; i < len(maxIndices); i++ {
		p1 := maxIndices[i]
		p2 := maxIndices[(i+1)%len(maxIndices)]

		// Calculate segment length, handling circularity.
		segmentLength := (p2 - p1 + n) % n
		if segmentLength == 0 { // This happens if there's only one maxVal mountain or all are maxVal (handled above)
			continue
		}

		// Iterate through mountains in the segment (excluding p1 and p2).
		// The segment is (p1+1)%n, ..., (p2-1+n)%n.
		// The number of steps from p1 to p2 (inclusive) is segmentLength + 1.
		// The number of intermediate mountains is segmentLength - 1.
		for k := 1; k < segmentLength; k++ { // k is distance from p1
			x := (p1 + k) % n

			// d is the minimum distance from x to either p1 or p2.
			distLeft := k
			distRight := segmentLength - k
			d := int(math.Min(float64(distLeft), float64(distRight)))

			// Calculate time for heights[x] to become zero.
			// It takes 'd' seconds for the erosion wave to reach heights[x].
			// During these 'd' seconds, heights[x] is reduced by 'd' (manual).
			// Remaining height: heights[x] - d.
			// This remaining height is then reduced by 2 per second (manual + erosion).
			// Time for remaining height: ceil((heights[x] - d) / 2).
			// Total time: d + ceil((heights[x] - d) / 2).
			// Make sure heights[x] - d is not negative before ceil.

			remainingHeight := heights[x] - d
			currentTime := d
			if remainingHeight > 0 {
				currentTime += (remainingHeight + 1) / 2 // ceil(remainingHeight / 2)
			}

			if currentTime > ans {
				ans = currentTime
			}
		}
	}

	return ans
}