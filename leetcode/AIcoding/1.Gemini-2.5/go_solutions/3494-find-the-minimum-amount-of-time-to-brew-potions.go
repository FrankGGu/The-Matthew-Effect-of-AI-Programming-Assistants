package main

func minTime(potions []int, materials []int, k int) int64 {
	n := len(potions)

	check := func(time int64) bool {
		var totalBatchesNeeded int64 = 0
		for i := 0; i < n; i++ {
			// Calculate the number of batches required for potion i.
			// (potions[i] + k - 1) / k is equivalent to ceil(potions[i] / k)
			batchesForPotionI := (int64(potions[i]) + int64(k) - 1) / int64(k)
			totalBatchesNeeded += batchesForPotionI

			// If the total batches required already exceeds the given time,
			// it's not possible to brew all potions within this time.
			if totalBatchesNeeded > time {
				return false
			}
		}
		return true
	}

	var low int64 = 0
	// The maximum possible time can be estimated as:
	// max_potions_units * max_batches_per_unit * num_potions
	// (10^9 units / 1 k-unit batch) * 10^5 potions = 10^14 batches (time units)
	var high int64 = 1e14 // A sufficiently large upper bound for the total time
	var ans int64 = high

	for low <= high {
		mid := low + (high-low)/2
		if check(mid) {
			ans = mid
			high = mid - 1
		} else {
			low = mid + 1
		}
	}

	return ans
}