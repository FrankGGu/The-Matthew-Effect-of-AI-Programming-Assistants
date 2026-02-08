package main

func waysToSplitArray(nums []int) int {
	const MOD = 1_000_000_007

	var onesIndices []int
	for i, num := range nums {
		if num == 1 {
			onesIndices = append(onesIndices, i)
		}
	}

	if len(onesIndices) == 0 {
		return 0
	}

	totalWays := 1

	for j := 0; j < len(onesIndices)-1; j++ {
		diff := onesIndices[j+1] - onesIndices[j]
		totalWays = (totalWays * diff) % MOD
	}

	return totalWays
}