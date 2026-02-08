func sumEvenAfterQueries(nums []int, queries [][]int) []int {
	sum := 0
	for _, num := range nums {
		if num%2 == 0 {
			sum += num
		}
	}

	result := make([]int, len(queries))
	for i, query := range queries {
		val := query[0]
		index := query[1]

		if nums[index]%2 == 0 {
			sum -= nums[index]
		}

		nums[index] += val

		if nums[index]%2 == 0 {
			sum += nums[index]
		}

		result[i] = sum
	}

	return result
}