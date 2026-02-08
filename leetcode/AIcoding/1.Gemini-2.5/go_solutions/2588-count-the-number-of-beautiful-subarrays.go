package main

func numberOfSubarrays(nums []int, k int) int {
	count := 0
	ans := 0
	freqMap := make(map[int]int)
	freqMap[0] = 1

	for _, num := range nums {
		if num%2 != 0 {
			count++
		}

		if val, ok := freqMap[count-k]; ok {
			ans += val
		}

		freqMap[count]++
	}

	return ans
}