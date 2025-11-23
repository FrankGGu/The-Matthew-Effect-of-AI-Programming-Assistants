package main

func canArrange(arr []int, k int) bool {
	if len(arr)%2 != 0 {
		return false
	}

	remainderCounts := make(map[int]int)
	for _, num := range arr {
		remainder := num % k
		if remainder < 0 {
			remainder += k
		}
		remainderCounts[remainder]++
	}

	if remainderCounts[0]%2 != 0 {
		return false
	}

	for i := 1; i <= k/2; i++ {
		if i == k-i { // This means i is k/2, only happens if k is even
			if remainderCounts[i]%2 != 0 {
				return false
			}
		} else { // i and k-i are distinct remainders
			if remainderCounts[i] != remainderCounts[k-i] {
				return false
			}
		}
	}

	return true
}