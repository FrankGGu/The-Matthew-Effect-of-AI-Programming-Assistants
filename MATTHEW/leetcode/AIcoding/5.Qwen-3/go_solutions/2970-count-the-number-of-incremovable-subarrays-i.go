package main

func numberOfSubarrays(nums []int) int {
	n := len(nums)
	count := 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			valid := true
			for k := i; k < j; k++ {
				if nums[k] >= nums[k+1] {
					valid = false
					break
				}
			}
			if valid {
				count++
			}
		}
	}
	return count
}