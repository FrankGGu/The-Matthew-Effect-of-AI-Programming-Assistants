package main

func numOfSubarrays(arr []int, k int, threshold int) int {
	count := 0
	currentSum := 0

	for i := 0; i < k; i++ {
		currentSum += arr[i]
	}

	targetSum := threshold * k

	if currentSum >= targetSum {
		count++
	}

	for i := k; i < len(arr); i++ {
		currentSum = currentSum - arr[i-k] + arr[i]
		if currentSum >= targetSum {
			count++
		}
	}

	return count
}