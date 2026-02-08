package main

func countGoodMeals(deliciousness []int) int {
	const MOD = 1_000_000_007

	// Precompute powers of two.
	// The maximum deliciousness[i] is 2^20.
	// The maximum sum of two dishes is 2^20 + 2^20 = 2^21.
	// So, we need to consider powers of two from 2^0 up to 2^21.
	powersOfTwo := make([]int, 22)
	for i := 0; i < 22; i++ {
		powersOfTwo[i] = 1 << i
	}

	freqMap := make(map[int]int)
	count := 0

	// Iterate through each dish price
	for _, price := range deliciousness {
		// For the current price, check if it can form a good meal with any previously seen prices
		for _, targetSum := range powersOfTwo {
			complement := targetSum - price
			// A valid complement must be non-negative
			// And it must exist in our frequency map
			if complement >= 0 {
				if c, ok := freqMap[complement]; ok {
					count = (count + c) % MOD
				}
			}
		}
		// After checking all possible pairs for the current price, add it to the frequency map
		freqMap[price]++
	}

	return count
}