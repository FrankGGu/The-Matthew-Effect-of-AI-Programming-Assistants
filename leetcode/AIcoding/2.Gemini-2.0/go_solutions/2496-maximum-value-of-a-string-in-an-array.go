import (
	"strconv"
)

func maximumValue(strs []string) int {
	maxVal := 0
	for _, str := range strs {
		num, err := strconv.Atoi(str)
		val := 0
		if err == nil {
			val = num
		} else {
			val = len(str)
		}
		if val > maxVal {
			maxVal = val
		}
	}
	return maxVal
}