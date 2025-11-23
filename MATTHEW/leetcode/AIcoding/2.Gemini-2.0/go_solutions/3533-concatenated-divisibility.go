func concatenatedDivisibility(nums []int, k int) int {
	count := 0
	for _, num := range nums {
		concat := 0
		temp := num
		digits := 0
		if temp == 0 {
			digits = 1
		} else {
			for temp > 0 {
				temp /= 10
				digits++
			}
		}

		pow10 := 1
		for i := 0; i < digits; i++ {
			pow10 *= 10
		}

		concat = nums[0]*pow10 + num

		if concat%k == 0 {
			count++
		}
	}

	result := 0
	for i := 0; i < len(nums); i++ {
		concat := 0
		temp := nums[i]
		digits := 0
		if temp == 0 {
			digits = 1
		} else {
			for temp > 0 {
				temp /= 10
				digits++
			}
		}

		pow10 := 1
		for j := 0; j < digits; j++ {
			pow10 *= 10
		}

		concat = nums[0]*pow10 + nums[i]

		if concat%k == 0 {
			result++
		}
	}

	count = 0
	for i := 0; i < len(nums); i++ {
		concat := 0
		temp := nums[i]
		digits := 0
		if temp == 0 {
			digits = 1
		} else {
			for temp > 0 {
				temp /= 10
				digits++
			}
		}

		pow10 := 1
		for j := 0; j < digits; j++ {
			pow10 *= 10
		}

		concat = nums[0]*pow10 + nums[i]

		if concat%k == 0 {
			count++
		}
	}

	final_count := 0
	for i := 0; i < len(nums); i++ {
		number := nums[i]

		powerOfTen := 1
		temp := number
		numDigits := 0

		if temp == 0 {
			numDigits = 1
		} else {
			for temp > 0 {
				temp /= 10
				numDigits++
			}
		}

		for j := 0; j < numDigits; j++ {
			powerOfTen *= 10
		}

		concatenatedNumber := nums[0]*powerOfTen + number

		if concatenatedNumber%k == 0 {
			final_count++
		}
	}

	return final_count
}