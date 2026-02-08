import "sort"

func canThreePartsEqualSum(arr []int) bool {
	sum := 0
	for _, num := range arr {
		sum += num
	}

	if sum%3 != 0 {
		return false
	}

	target := sum / 3
	count := 0
	currSum := 0
	for _, num := range arr {
		currSum += num
		if currSum == target {
			count++
			currSum = 0
		}
	}

	return count >= 3
}

func threeEqualParts(arr []int) []int {
	ones := 0
	for _, num := range arr {
		if num == 1 {
			ones++
		}
	}

	if ones%3 != 0 {
		return []int{-1, -1}
	}

	if ones == 0 {
		return []int{0, 2}
	}

	targetOnes := ones / 3
	firstEnd := -1
	secondEnd := -1
	thirdEnd := -1

	count := 0
	for i := 0; i < len(arr); i++ {
		if arr[i] == 1 {
			count++
		}
		if count == targetOnes {
			firstEnd = i
			break
		}
	}

	count = 0
	for i := firstEnd + 1; i < len(arr); i++ {
		if arr[i] == 1 {
			count++
		}
		if count == targetOnes {
			secondEnd = i
			break
		}
	}

	count = 0
	for i := secondEnd + 1; i < len(arr); i++ {
		if arr[i] == 1 {
			count++
		}
		if count == targetOnes {
			thirdEnd = i
			break
		}
	}

	len1 := firstEnd + 1
	len2 := secondEnd - firstEnd
	len3 := thirdEnd - secondEnd

	if len1 > len(arr)-thirdEnd-1 || len2 > len(arr)-thirdEnd-1 {
		return []int{-1, -1}
	}

	for i := 0; i < len(arr)-thirdEnd-1; i++ {
		if (firstEnd+1+i >= len1 || secondEnd+1+i >= firstEnd+1+len2) {
			return []int{-1, -1}
		}

		if arr[i] != arr[firstEnd+1+i] || arr[i] != arr[secondEnd+1+i] {
			return []int{-1, -1}
		}
	}

	return []int{firstEnd + len(arr)-thirdEnd-1, secondEnd + len(arr)-thirdEnd}
}

func minimumDifference(nums []int, k int) int {
	sort.Ints(nums)
	ans := nums[k-1] - nums[0]
	for i := 1; i <= len(nums)-k; i++ {
		ans = min(ans, nums[i+k-1]-nums[i])
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}