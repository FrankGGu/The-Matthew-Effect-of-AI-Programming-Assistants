func countSubarrays(nums []int) int64 {
	n := len(nums)
	var ans int64
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			temp := make([]int, 0)
			for k := 0; k < n; k++ {
				if k < i || k > j {
					temp = append(temp, nums[k])
				}
			}
			if len(temp) == 0 {
				ans++
				continue
			}
			sorted := true
			for k := 1; k < len(temp); k++ {
				if temp[k] <= temp[k-1] {
					sorted = false
					break
				}
			}
			if sorted {
				ans++
			}
		}
	}
	return ans
}