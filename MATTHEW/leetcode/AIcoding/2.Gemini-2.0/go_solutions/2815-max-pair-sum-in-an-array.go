import "math"

func maxSum(nums []int) int {
	maxSum := -1
	maxDigitMap := make(map[int]int)

	for _, num := range nums {
		maxDigit := 0
		temp := num
		for temp > 0 {
			digit := temp % 10
			if digit > maxDigit {
				maxDigit = digit
			}
			temp /= 10
		}

		if val, ok := maxDigitMap[maxDigit]; ok {
			maxSum = int(math.Max(float64(maxSum), float64(val+num)))
			if num > maxDigitMap[maxDigit] {
				maxDigitMap[maxDigit] = num
			}
		} else {
			maxDigitMap[maxDigit] = num
		}
	}

	return maxSum
}