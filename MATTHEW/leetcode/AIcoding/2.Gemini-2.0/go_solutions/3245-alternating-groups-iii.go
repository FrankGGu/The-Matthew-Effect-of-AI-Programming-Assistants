func alternatingSubarray(nums []int) int {
	ans := -1
	for i := 0; i < len(nums); i++ {
		for j := i + 1; j < len(nums); j++ {
			length := j - i + 1
			if length > 1 && length%2 == 0 {
				flag := true
				for k := i; k < j; k++ {
					if nums[k+1]-nums[k] != (k-i)%2*2-1 {
						flag = false
						break
					}
				}
				if flag {
					if length > ans {
						ans = length
					}
				}
			} else if length > 1 && length%2 != 0 {
				flag := true
				for k := i; k < j; k++ {
					if nums[k+1]-nums[k] != (k-i)%2*2-1 {
						flag = false
						break
					}
				}
				if flag {
					if length > ans {
						ans = length
					}
				}
			}
		}
	}
	return ans
}