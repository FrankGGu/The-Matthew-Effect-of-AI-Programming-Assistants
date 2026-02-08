import (
	"math"
)

func sumDigitDifferences(nums []int) int {
	n := len(nums)
	ans := 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			ans += int(math.Abs(float64(maxDigit(nums[i]) - maxDigit(nums[j]))))
			ans += int(math.Abs(float64(minDigit(nums[i]) - minDigit(nums[j]))))
		}
	}
	return ans
}

func maxDigit(num int) int {
	max := 0
	for num > 0 {
		digit := num % 10
		if digit > max {
			max = digit
		}
		num /= 10
	}
	return max
}

func minDigit(num int) int {
	min := 9
	for num > 0 {
		digit := num % 10
		if digit < min {
			min = digit
		}
		num /= 10
	}
	return min
}