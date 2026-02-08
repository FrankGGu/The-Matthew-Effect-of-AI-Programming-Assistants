func sortArrayByParityII(nums []int) []int {
	even := 0
	odd := 1
	for even < len(nums) && odd < len(nums) {
		if nums[even]%2 == 0 {
			even += 2
		} else if nums[odd]%2 == 1 {
			odd += 2
		} else {
			nums[even], nums[odd] = nums[odd], nums[even]
			even += 2
			odd += 2
		}

		if even >= len(nums) || odd >= len(nums) {
			break
		}
	}
	even = 0
	odd = 1
	for even < len(nums) && odd < len(nums) {
		if nums[even]%2 == 0 {
			even += 2
		} else {
			for nums[odd]%2 != 1 {
				odd += 2
				if odd >= len(nums) {
					break
				}
			}
			if odd < len(nums){
				nums[even], nums[odd] = nums[odd], nums[even]
				even += 2
				odd += 2
			} else {
				break
			}

		}
		if even >= len(nums) || odd >= len(nums) {
			break
		}
	}
	return nums
}