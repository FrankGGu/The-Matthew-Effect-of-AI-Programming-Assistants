func maxSubarrays(nums []int) int {
	result := nums[0]
	count := 1
	for i := 1; i < len(nums); i++ {
		result &= nums[i]
		if result == 0 {
			count++
			if i+1 < len(nums){
				result = nums[i+1]
				i++
				for j := i+1; j < len(nums); j++{
					result &= nums[j]
					if result == 0{
						count++
						if j+1 < len(nums){
							result = nums[j+1]
							j++
							i = j
							break
						} else{
							return count
						}

					}
					i = j
				}
				return count
			} else{
				return count
			}

		}
	}
	return count
}