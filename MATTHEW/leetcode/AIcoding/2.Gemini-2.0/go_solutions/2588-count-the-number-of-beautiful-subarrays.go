func beautifulSubarrays(nums []int) int64 {
	count := int64(0)
	xor := 0
	freq := make(map[int]int)
	freq[0] = 1

	for _, num := range nums {
		xor ^= num
		count += int64(freq[xor])
		freq[xor]++
	}

	return count
}