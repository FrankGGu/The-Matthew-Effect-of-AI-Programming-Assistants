func kmpTable(pattern []int) []int {
	n := len(pattern)
	table := make([]int, n)
	length := 0
	table[0] = 0
	i := 1
	for i < n {
		if pattern[i] == pattern[length] {
			length++
			table[i] = length
			i++
		} else {
			if length != 0 {
				length = table[length-1]
			} else {
				table[i] = 0
				i++
			}
		}
	}
	return table
}

func kmpSearch(text []int, pattern []int) int {
	n := len(text)
	m := len(pattern)
	table := kmpTable(pattern)
	i := 0
	j := 0
	count := 0
	for i < n {
		if text[i] == pattern[j] {
			i++
			j++
		}
		if j == m {
			count++
			j = table[j-1]
		} else if i < n && text[i] != pattern[j] {
			if j != 0 {
				j = table[j-1]
			} else {
				i++
			}
		}
	}
	return count
}

func countMatchingSubarrays(nums []int, pattern []int) int {
	n := len(nums)
	text := make([]int, n-1)
	for i := 0; i < n-1; i++ {
		if nums[i+1] > nums[i] {
			text[i] = 1
		} else if nums[i+1] < nums[i] {
			text[i] = -1
		} else {
			text[i] = 0
		}
	}

	return kmpSearch(text, pattern)
}