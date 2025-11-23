func longestMountain(arr []int) int {
	n := len(arr)
	if n < 3 {
		return 0
	}

	ans := 0
	i := 0
	for i < n {
		j := i
		// Step 1: Find the base of a potential mountain (start of an ascent)
		// Skip flat or strictly descending parts
		for j+1 < n && arr[j] >= arr[j+1] {
			j++
		}

		// Step 2: Find the peak of the mountain
		// `j` is now the start of a potential ascent (or end of array/flat segment)
		peak := j
		for peak+1 < n && arr[peak] < arr[peak+1] {
			peak++
		}

		// Step 3: Find the end of the descent
		// `peak` is now the potential peak
		descent := peak
		for descent+1 < n && arr[descent] > arr[descent+1] {
			descent++
		}

		// Step 4: Check if a valid mountain was found
		// A mountain requires both an ascent (peak > j) and a descent (descent > peak)
		if peak > j && descent > peak {
			ans = max(ans, descent-j+1)
			// If a mountain is found, continue searching from the end of this mountain
			i = descent
		} else {
			// If no valid mountain was found (e.g., only ascent, only descent, or flat)
			// Advance `i` to ensure progress. `max(descent, i+1)` handles cases:
			// - `peak == j` (no ascent): `descent` will be `j`. `i` becomes `max(j, i+1)`.
			//   If `i` was `j`, `i` becomes `j+1`. Correct.
			// - `descent == peak` (no descent after ascent): `i` becomes `max(peak, i+1)`.
			//   If `i` was `j`, `i` becomes `max(peak, j+1)`. Correct.
			i = max(descent, i+1)
		}
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}