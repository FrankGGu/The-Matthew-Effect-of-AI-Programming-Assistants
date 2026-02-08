func countArrangement(n int) int {
	nums := make([]int, n)
	for i := 0; i < n; i++ {
		nums[i] = i + 1
	}
	count := 0
	var permute func(int)
	permute = func(index int) {
		if index == n {
			count++
			return
		}
		for i := index; i < n; i++ {
			nums[index], nums[i] = nums[i], nums[index]
			if nums[index]%(index+1) == 0 || (index+1)%nums[index] == 0 {
				permute(index + 1)
			}
			nums[index], nums[i] = nums[i], nums[index]
		}
	}
	permute(0)
	return count
}